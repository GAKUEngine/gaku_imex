module Gaku
  module Exporters
    class TemplateIndex
      @template_list = []
      @template_scope = :none

      def self.scope
        @template_scope
      end

      def self.template_classes
        @template_list
      end

      def self.template_names
        @template_list.map {|template| template.template_name}
      end
    end
  end
end
