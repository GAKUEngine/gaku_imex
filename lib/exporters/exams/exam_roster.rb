require_relative '../template'

module Gaku
  module Exporters
    module Exams
      class ExamRoster < Gaku::Exporters::Template
        @name_def = 'Exam Roster'

        def self.generate(data)
          report = ThinReports::Report.new layout: File.join(Gaku::Imex::Engine.root,  'app', 'reports', 'exam_roster.tlf')
          report.start_new_page do |page|
            page.item(:exam_name).value data[:exam][:name]
            page.item(:exam_location).value 'exam_location'

            data[:students].each do |student|
              page.list("exam_roster").add_row do |row|
                row.item(:index_number).value(student.id)
                row.item(:examinee_number).value(student.id)
                row.item(:examinee_name).value student.surname + ' ' + student.name
                row.item(:examinee_name_reading).value student.surname_reading + ' ' + student.name_reading
                if student.external_school_records_count
                  school_name = student.external_school_records.last.school.name
                else
                  school_name = 'none'
                end
                row.item(:origin_junior_high).value school_name
                row.item(:attendance).value(student.id)
              end
            end
          end
          report.generate
        end
      end
    end
  end
end
