require_relative '../template'

module Gaku
  module Exporters
    module Exams
      class ResultsRoster < Gaku::Exporters::Template
        @name = 'Results Roster'

        def generate(data)
          # TODO export tlf
        end
      end
    end
  end
end
