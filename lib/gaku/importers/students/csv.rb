module Gaku::Importers::Students
  class Csv
    include Gaku::Importers::Students::StudentIdentity

    attr_reader :csv

    def initialize(file_path)
      @csv = SmarterCSV.process(file_path)
    end

    def import
      enrollment_status_code = Gaku::EnrollmentStatus.where(code: 'enrolled', active: true, immutable: true)
                                                     .first_or_create!.try(:code)

      ActiveRecord::Base.transaction do
        @csv.each_with_index do |row|
          student = Gaku::Student.new(row)
          student.enrollment_status_code = enrollment_status_code
          student.save
        end
      end
    end

  end
end
