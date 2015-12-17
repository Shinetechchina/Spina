module Spina
  module Admin
    class ComponentsController < AdminController
      before_filter :set_breadcrumb

      layout "spina/admin/website"

      def show
        @component = Component.find(params[:id])
      end

      def index
        @components = Component.all
      end

      def new
        add_breadcrumb "New component", new_admin_component_path
        @component = Component.new
      end

      def edit
        @component = Component.find(params[:id])
        add_breadcrumb @component.name
      end

      def create
        @component = Component.new(component_params)

        path = Rails.root.join('app', 'assets', 'javascripts',"#{current_theme.name}",'js','components')
        FileUtils.mkdir_p(path) unless Dir.exist?(path)
        @component.file_path = path.join("#{@component.name.parameterize}.es6.jsx").to_s

        add_breadcrumb "New component"
        if @component.save
          redirect_to action: :edit, id: @component.id
        else
          render :new
        end
      end

      def update
        @component = Component.find(params[:id])

        add_breadcrumb @component.name
        if @component.update_attributes(component_params)
          redirect_to :back
        else
          render :edit
        end
      end

      def destroy
        @component = Component.find(params[:id])
        @component.destroy
        redirect_to admin_components_url, notice: "The component has beed destroyed."
      end

      private

      def set_breadcrumb
        add_breadcrumb "Components", admin_components_path
      end

      def component_params
        params.require(:component).permit(:name, :use_for, :file_path, :content)
      end
    end
  end
end
