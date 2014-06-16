module Gaku::Importers::Students
  class Csv
    include Gaku::Importers::Students::StudentIdentity

    attr_reader :csv, :import_file_id

    def initialize(import_file_id, path)
      @import_file_id = import_file_id
      @csv = SmarterCSV.process(path)
    end

    def import
      cleanup_student_states

      enrollment_status_code = Gaku::EnrollmentStatus.where(code: 'enrolled', active: true, immutable: true)
                                                     .first_or_create!.try(:code)

      ActiveRecord::Base.transaction do
        @csv.each do |row|

          next if student_record(row)

          student = Gaku::Student.new(filter_row(row))
          student.enrollment_status_code = enrollment_status_code

          if student.save
            $redis.rpush "import_file:#{@import_file_id}:created", student.id
          else
            $redis.rpush "import_file:#{@import_file_id}:not_saved", not_saved_students(student)
          end
        end
      end
    end

    private

    def student_record(row)
      Gaku::Student.where(foreign_id_code: row[:foreign_id_code].to_s).first.try(:tap) do |student|
        $redis.rpush "import_file:#{@import_file_id}:duplicated", student.id
      end
    end

    def filter_row(row)
      row.select { |k, v| Gaku::Student.csv_column_fields.include?(k.to_s) }
    end

    def not_saved_students(student)
      "#{student.foreign_id_code}, #{student.name}, #{student.surname}"
    end

    def cleanup_student_states
      %w( created duplicated not_saved ).each do |state|
        $redis.del "import_file:#{@import_file_id}:#{state}"
      end
    end

  end
end
