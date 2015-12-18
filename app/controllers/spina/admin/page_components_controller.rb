module Spina
  module Admin
    class PageComponentsController < AdminController
      def index
        @page_components = Page.find(params[:page_id]).page_components
        @components = Component.all
      end

      def new
        page = Page.find(params[:page_id])
        @component = Component.find(params[:component_id])
        @page_component = PageComponent.new(component_id: params[:component_id], page_id: page.id)
        @component.component_params.each do |component_param|
          @page_component.page_component_params.new(component_param_id: component_param.id)
        end
      end

      def create
        PageComponent.create(create_params)
        redirect_to :back
      end

      def update
        PageComponent.update(params[:id], update_params)
        redirect_to :back
      end

      def destroy
        PageComponent.find_by(id: params[:id]).try(:destroy)
        redirect_to :back
      end

      private
      def create_params
        params.require(:page_component).permit(:component_id, :page_id, page_component_params_attributes: [:component_param_id, :param_value])
      end
      def update_params
        params.require(:page_component).permit(:component_id, :page_id, page_component_params_attributes: [:id, :component_param_id, :param_value])
      end
    end
  end
end
