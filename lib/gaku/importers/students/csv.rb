module Gaku::Importers::Students
  class Csv
    include Gaku::Importers::Students::StudentIdentity

    attr_reader :csv

    def initialize(file_path)
      @csv = SmarterCSV.process(file_path)
      @students = { created: [], with_errors: [], duplicated: [] }
    end

    def import
      enrollment_status_code = Gaku::EnrollmentStatus.where(code: 'enrolled', active: true, immutable: true)
                                                     .first_or_create!.try(:code)

      ActiveRecord::Base.transaction do
        @csv.each_with_index do |row|
          next if check_registration(row)

          student = Gaku::Student.new(row)
          student.enrollment_status_code = enrollment_status_code

          if student.save
            @students[:created] << student
          else
            @students[:with_errors] << student
          end
        end
      end
      @students
    end

    private

    def check_registration(row)
      #return true if row[:id].nil? || row[:id] == ""
      return true if check_foreign_id_code(row)
      false
    end

    def check_foreign_id_code(row)
      if Gaku::Student.exists?(foreign_id_code: row[:foreign_id_code].to_s)
        @students[:duplicated] << Gaku::Student.where(foreign_id_code: row[:foreign_id_code].to_s).first
      end
    end

  end
end
