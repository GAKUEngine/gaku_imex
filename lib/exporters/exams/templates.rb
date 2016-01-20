require_relative '../template_index'

require_relative 'exam_roster'
require_relative 'result_notice'

module Gaku
  module Exporters
    module Exams
      class Templates < Gaku::Exporters::TemplateIndex
        @template_scope = :exams
        @template_list = [
          Gaku::Exporters::Exams::ExamRoster,
          Gaku::Exporters::Exams::ResultNotice
        ]
      end
    end
  end
end
