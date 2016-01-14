module Gaku
  module Exporters
    class Template
      attr_reader :name
      # override in each class
      @name_def = 'Base Template'

      def self.template_name
        @name_def
      end

      # returns a file object
      # returns nil if export failed
      def self.generate(data)
        nil
      end

      def initialize
        @name = self.class.template_name
      end
    end
  end
end
