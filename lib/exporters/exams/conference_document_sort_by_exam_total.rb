require_relative '../template'

module Gaku
  module Exporters
    module Exams
      class ConferenceDocumentSortByExamTotal < Gaku::Exporters::Template
        @name_def = 'Conference Document Sort By Exam Total'

        def self.generate(data)
          # portion names --------
          # 試験：国語
          # 試験：数学
          # 試験：英語
          # 内申：国語
          # 内申：社会
          # 内申：数学
          # 内申：理科
          # 内申：音楽
          # 内申：美術
          # 内申：体育
          # 内申：技術家庭
          # 内申：外国語
          # 欠席数：中２
          # 欠席数：中３
          def self.get_added_total_score_students(data)
            new_students = []
            data[:students].map do |student|
              scores = student.exam_portion_scores.select {|score| score[:gradable_id] === data[:exam_session][:id]}

              total_score = 0
              scores.each do |score|
                case score.exam_portion.name
                when '試験：国語'
                  total_score += score[:score].to_i
                when '試験：数学'
                  total_score += score[:score].to_i
                when '試験：英語'
                  total_score += score[:score].to_i
                end
              end
              new_students.push student: student, exam_total: total_score, scores: scores
            end
            new_students
          end

          report = ThinReports::Report.new layout: File.join(Gaku::Imex::Engine.root,  'app', 'reports', 'conference_document.tlf')

          report.start_new_page do |page|
            exam_date = data[:exam_session][:session_start].to_s
            report_name =  "推薦入試試験　点呼用紙　（#{exam_date}実施）"

            page.item(:report_name).value report_name
            page.item(:sort_order).value '入試成績順'
            page.item(:created_date).value Date.today.to_s

            students = get_added_total_score_students data
            students.sort! {|a, b| b[:exam_total] <=> a[:exam_total]}

            students.each_with_index do |student_data, i|
              page.list("examinee_list").add_row do |row|
                row.item(:rank).value i + 1

                row.item(:examinee_number).value student_data[:student][:serial_id]
                row.item(:aspiring_department).value "test"
                row.item(:examinee_name).value "#{student_data[:student][:surname].to_s} #{student_data[:student][:name].to_s}"

                if student_data[:student].external_school_records.present?
                  school_name = student_data[:student].external_school_records.last.school.name
                else
                  school_name = 'none'
                end
                row.item(:origin_junior_high).value school_name

                subjects_9 = 0
                subjects_5 = 0
                subjects_3 = 0
                student_data[:scores].each do |score|
                  case score.exam_portion.name
                  when '試験：国語'
                    row.item(:language_arts).value score[:score].to_i
                  when '試験：数学'
                    row.item(:math).value score[:score].to_i
                  when '試験：英語'
                    row.item(:english).value score[:score].to_i

                  when '内申：国語'
                    subjects_9 += score[:score].to_i
                    subjects_5 += score[:score].to_i
                    subjects_3 += score[:score].to_i
                  when '内申：社会'
                    subjects_9 += score[:score].to_i
                    subjects_5 += score[:score].to_i
                  when '内申：数学'
                    subjects_9 += score[:score].to_i
                    subjects_5 += score[:score].to_i
                    subjects_3 += score[:score].to_i
                  when '内申：理科'
                    subjects_9 += score[:score].to_i
                    subjects_5 += score[:score].to_i
                  when '内申：音楽'
                    subjects_9 += score[:score].to_i
                  when '内申：美術'
                    subjects_9 += score[:score].to_i
                  when '内申：体育'
                    subjects_9 += score[:score].to_i
                  when '内申：技術家庭'
                    subjects_9 += score[:score].to_i
                  when '内申：外国語'
                    subjects_9 += score[:score].to_i
                    subjects_5 += score[:score].to_i
                    subjects_3 += score[:score].to_i

                  when '欠席数：中２'
                    row.item(:'2nd_year_middle_school').value score[:score].to_i
                  when '欠席数：中３'
                    row.item(:'3rd_year_middle_school').value score[:score].to_i
                  end
                end
                row.item(:total).value student_data[:exam_total]
                row.item(:'9_subjects').value subjects_9
                row.item(:'5_subjects').value subjects_5
                row.item(:'3_subjects').value subjects_3
              end
            end
          end

          report.generate
        end
      end
    end
  end
end
