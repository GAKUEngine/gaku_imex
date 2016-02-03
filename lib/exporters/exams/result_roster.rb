require_relative '../template'

module Gaku
  module Exporters
    module Exams
      class ResultRoster < Gaku::Exporters::Template
        @name_def = 'Result Roster'

        def self.generate(data)
          report = ThinReports::Report.new layout: File.join(Gaku::Imex::Engine.root,  'app', 'reports', 'result_roster.tlf')
          report.start_new_page do |page|
            page.item(:report_name).value data[:exam][:name]
            page.item(:date).value Date.tody.to_s

            data[:students].each_with_index do |student, i|
              row.item(:index).value i + 1

              if student.external_school_records.present?
                school_name = student.external_school_records.last.school.name
              else
                school_name = 'none'
              end
              row.item(:origin_junior_high).value school_name

              row.item(:aspiring_department).value 'aspiring_department'
              row.item(:examinee_number).value student[:serial_id]
              row.item(:examinee_name).value "#{student[:surname].to_s} #{student[:name].to_s}"
              row.item(:result).value ''
              row.item(:comment).value ''
            end
          end
          report.generate
        end
      end
    end
  end
end
