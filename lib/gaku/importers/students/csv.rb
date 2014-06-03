module Gaku::Importers::Students
  class Csv
    include Gaku::Importers::Students::StudentIdentity

    attr_reader :csv

    def initialize(file_path)
      @csv = SmarterCSV.process(file_path)
    end

    def import
      students = { created: [], with_errors: [], duplicated: []}
      enrollment_status_code = Gaku::EnrollmentStatus.where(code: 'enrolled', active: true, immutable: true)
                                                     .first_or_create!.try(:code)

      ActiveRecord::Base.transaction do
        @csv.each_with_index do |row|
          next if check_registration(row)
          student = Gaku::Student.new(row)
          student.enrollment_status_code = enrollment_status_code
          if student.save
            students[:created] << student
          else
            students[:with_errors] << student
          end
        end
      end
      students
    end

    def check_registration(row)
      return true if row.id.nil? || row.id == ""
      return true if Gaku::Student.exists?(foreign_id_code: row.foreign_id_code)
      false
    end
  end
end
