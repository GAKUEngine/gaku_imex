require_relative '../template_index'

require_relative 'result_notice'
require_relative 'results_roster'

module Gaku
  module Exporters
    module Exams
      class Templates < Gaku::Exporters::TemplateIndex
        @template_scope = :exams
        @template_list = [
          Gaku::Exporters::Exams::ResultsRoster,
          Gaku::Exporters::Exams::ResultNotice
        ]
      end
    end
  end
end
