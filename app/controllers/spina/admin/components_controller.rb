module Spina
  module Admin
    class ComponentsController < AdminController
      before_filter :set_breadcrumb
      before_action :set_component, only: [:show, :edit, :update, :destroy]
      before_action :check_page_use, only: [:destroy]

      layout "spina/admin/website"

      def index
        @components = proxy_chain
      end

      def show
        add_breadcrumb "#{@component.name}", admin_component_path(@component)
      end

      def new
        add_breadcrumb "New component", new_admin_component_path
        @component = proxy_chain.new
      end

      def edit
        add_breadcrumb @component.name
      end

      def create
        @component = proxy_chain.new(component_params)

        add_breadcrumb "New component"
        if @component.save
          redirect_to admin_component_path(@component)
        else
          render :new
        end
      end

      def update
        add_breadcrumb @component.name
        if @component.update_attributes(component_params)
          redirect_to admin_component_path(@component)
        else
          render :edit
        end
      end

      def destroy
        @component.destroy
        redirect_to admin_components_path, notice: I18n.t('spina.notifications.destroyed')
      end

      private

      def proxy_chain
        current_user.components
      end

      def set_component
        @component = proxy_chain.find(params[:id])
      end

      def set_breadcrumb
        add_breadcrumb "Components", admin_components_path
      end

      def component_params
        params.require(:component).permit(:name, :use_for, :content,
          component_params_attributes: [:id, :name, :use_for]
          )
      end

      def check_page_use
        if @component.present? && @component.component_params.any? {|c| c.page_component_params.any?}
          redirect_to :back, alert: I18n.t('spina.notifications.modify_component_failed')
        end
      end
    end
  end
end
