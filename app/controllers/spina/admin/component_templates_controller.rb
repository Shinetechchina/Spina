module Spina
  module Admin
    class ComponentTemplatesController < AdminController
      before_filter :set_breadcrumb

      layout "spina/admin/website"

      def show
        @component = ComponentTemplate.find(params[:id])
      end

      def index
        @components = ComponentTemplate.all
      end

      def new
        add_breadcrumb "New component", new_admin_component_template_path

        @component = ComponentTemplate.new
      end

      def edit
        @component = ComponentTemplate.find(params[:id])
        add_breadcrumb @component.name
      end

      def create
        @component = ComponentTemplate.new(component_params)

        add_breadcrumb "New component"
        if @component.save
          redirect_to admin_component_templates_url, notice: "Component has been created."
        else
          render :new
        end
      end

      def update
        @component = ComponentTemplate.find(params[:id])

        add_breadcrumb @component.name
        if @component.update_attributes(component_params)
          redirect_to admin_component_templates_url, notice: "Component #{@component.name} has been updated."
        else
          render :edit
        end
      end

      def destroy
        @component = ComponentTemplate.find(params[:id])
        @component.destroy
        redirect_to admin_component_templates_url, notice: "The component has beed destroyed."
      end

      private

      def set_breadcrumb
        add_breadcrumb "Components", admin_component_templates_path
      end

      def component_params
        params.require(:component_template).permit(:name, :use_for, :file_path, :content)
      end
    end
  end
end