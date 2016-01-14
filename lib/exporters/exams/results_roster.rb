require_relative '../template'

module Gaku
  module Exporters
    module Exams
      class ResultsRoster < Gaku::Exporters::Template
        @name_def = 'Results Roster'

        def self.generate(data)
          report = ThinReports::Report.new layout: File.join(Gaku::Imex::Engine.root,  'app', 'reports', 'results_roster.tlf')
          report.start_new_page do |page|
            date = Date.today
            acceptance_name =  "#{date}　推薦入試試験　点呼用紙　（#{date}実施）"
            page.item(:acceptance_name).value acceptance_name
            page.item(:acceptance_location).value '光ヶ丘女子高等学校'

            data[:students].each do |student|
              page.list("applicants_list").add_row do |row|
                row.item(:index_number).value(student.id)
                row.item(:acceptance_number).value(student.id)
                row.item(:applicant_name).value(student.name)
                row.item(:applicant_name_reading).value(student.name_reading)
                row.item(:graduate_junior_high_school).value(student.id)
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
