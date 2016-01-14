module Gaku
  module Exporters
    class Template
      attr_reader :name
      # override
      @name = 'Base Template'

      def self.template_name
        @name
      end

      # returns a file object
      # returns nil if export failed
      def generate(data)
        nil
      end
    end
  end
end
