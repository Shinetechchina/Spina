module Spina
  module Admin
    module AdminHelper

      def icon(name)
        content_tag(:i, nil, class: "icon icon-#{name}")
      end

      def components
        Component.all
      end

      def page_components
        @page.page_components
      end
    end
  end
end
