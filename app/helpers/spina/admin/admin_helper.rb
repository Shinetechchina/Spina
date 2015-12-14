module Spina
  module Admin
    module AdminHelper

      def icon(name)
        content_tag(:i, nil, class: "icon icon-#{name}")
      end

      def component_templates
        ComponentTemplate.all
      end

      def components
        @page.components
      end
    end
  end
end
