module Spina
  module Admin
    class ComponentTemplatesController < AdminController
      before_filter :set_breadcrumb

      layout "spina/admin/website"

      def show
        @template = ComponentTemplate.find(params[:id])
      end

      def index
        @templates = ComponentTemplate.all
      end

      def new
        add_breadcrumb "New component", new_admin_component_template_path

        @template = ComponentTemplate.new
      end

      def edit
        @template = ComponentTemplate.find(params[:id])
        add_breadcrumb @template.name
      end

      def create
        @template = ComponentTemplate.new(component_params)

        add_breadcrumb "New component"
        if @template.save
          redirect_to admin_component_templates_url, notice: "Component has been created."
        else
          render :new
        end
      end

      def update
        @template = ComponentTemplate.find(params[:id])

        add_breadcrumb @template.name
        if @template.update_attributes(component_params)
          redirect_to admin_component_templates_url, notice: "Component #{@template.name} has been updated."
        else
          render :edit
        end
      end

      def destroy
        @template = ComponentTemplate.find(params[:id])
        @template.destroy
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