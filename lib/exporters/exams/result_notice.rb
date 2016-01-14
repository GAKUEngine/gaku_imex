require_relative '../template'

module Gaku
  module Exporters
    module Exams
      class ResultNotice < Gaku::Exporters::Template
        @name_def = 'Result Notice'

        def self.generate(data)
          # TODO export tlf
        end
      end
    end
  end
end
