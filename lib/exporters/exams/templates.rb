require_relative '../template_index'

require_relative 'exam_roster'
require_relative 'result_notice'
require_relative 'conference_document_sort_by_exam_total'
require_relative 'conference_document_sort_by_examinee_number'
require_relative 'result_roster'

module Gaku
  module Exporters
    module Exams
      class Templates < Gaku::Exporters::TemplateIndex
        @template_scope = :exams
        @template_list = [
          Gaku::Exporters::Exams::ExamRoster,
          Gaku::Exporters::Exams::ResultNotice,
          Gaku::Exporters::Exams::ConferenceDocumentSortByExamTotal,
          Gaku::Exporters::Exams::ConferenceDocumentSortByExamineeNumber,
          Gaku::Exporters::Exams::ResultRoster
        ]
      end
    end
  end
end
