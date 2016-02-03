require_relative '../template'

module Gaku
  module Exporters
    module Exams
      class ResultNotice < Gaku::Exporters::Template
        @name_def = 'Result Notice'

        def self.generate(data)
          report = ThinReports::Report.new layout: File.join(Gaku::Imex::Engine.root,  'app', 'reports', 'result_notice.tlf')

          data[:students].each do |student|
            report.start_new_page do |page|
              page.item(:result).value "合格通知書[普通科]"

              page.item(:acceptance_number).value student[:serial_id]
              page.item(:applicant_name).value  "#{student[:surname].to_s} #{student[:name].to_s}"

              page.item(:text).value "　あなたは平成２７年度本校推薦入試試験において、\n普通科に合格しましたからお知らせします。\n\n平成２７年１月３０日"
            end
          end
          report.generate
        end
      end
    end
  end
end
