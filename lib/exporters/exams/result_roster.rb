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
            page.item(:date).value Date.today.to_s

            data[:students].each_with_index do |student, i|
              page.list("examinee_list").add_row do |row|
                row.item(:index).value i + 1
                row.item(:examinee_number).value student[:serial_id]
                row.item(:examinee_name).value "#{student[:surname].to_s} #{student[:name].to_s}"
                row.item(:result).value ''
                row.item(:comment).value ''

                if student.external_school_records.present?
                  school_name = student.external_school_records.last.school.name
                else
                  school_name = 'none'
                end
                row.item(:origin_junior_high).value school_name

                scores = student.exam_portion_scores.select {|score| score[:gradable_id] === data[:exam_session][:id]}
                scores.each do |score|
                  case score.exam_portion.name
                  when '志望学科'
                    row.item(:aspiring_department).value score[:score_text]
                  end
                end
              end
            end
          end
          report.generate
        end
      end
    end
  end
end
