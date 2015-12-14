module Spina
  module Admin
    class ParamTemplatesController < AdminController
      
      def destroy
        ParamTemplate.find(params[:id]).destroy
        redirect_to :back
      end

      def new
        @component = ComponentTemplate.find(params[:component_template_id])
        @param_tempalte = @component.param_templates.build
        @component.param_templates << @param_tempalte
        @component
        redirect_to :back
      end

      def create
      end

      def update
        ParamTemplate.update(update_params[:id], update_params)
        render :nothing =>true
      end

      private
      def update_params
        params.permit(:id, :name, :param_type)
      end
    end
  end
end