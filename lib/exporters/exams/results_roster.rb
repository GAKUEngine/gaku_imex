require_relative '../template'

module Gaku
  module Exporters
    module Exams
      class ResultsRoster < Gaku::Exporters::Template
        @name_def = 'Results Roster'

        def self.generate(data)
          # TODO export tlf
        end
      end
    end
  end
end
