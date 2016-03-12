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
              scores = student.exam_portion_scores.select {|score| score[:gradable_id] === data[:exam_session][:id]}
              scores.each do |score|
                case score.exam_portion.name
                when '志望学科'
                  page.item(:result).value "合格通知書［#{score[:score_text]}］"
                  page.item(:text).value "　あなたは平成２７年度本校推薦入試試験において、\n#{score[:score_text]}に合格しましたからお知らせします。\n\n平成２７年１月３０日"
                end
              end

              page.item(:acceptance_number).value student[:serial_id]
              page.item(:applicant_name).value  "#{student[:surname].to_s} #{student[:name].to_s}"
            end
          end
          report.generate
        end
      end
    end
  end
end
