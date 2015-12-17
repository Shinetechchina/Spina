module Spina
  module Admin
    class ParamTemplatesController < AdminController
      
      def destroy
        ParamTemplate.find_by(id: params[:id]).try(:destroy)
        redirect_to :back
      end

      def new
        @component = ComponentTemplate.find(params[:component_template_id])
        @param_tempalte = @component.param_templates.build
        @param_tempalte.id = Time.now.to_i
      end

      def create
        ParamTemplate.create(create_params)
        redirect_to :back
      end

      def update
        ParamTemplate.update(params[:id], update_params)
        redirect_to :back
      end

      private
      def update_params
        params.require(:param_template).permit(:id, :name, :use_for, :component_template_id)
      end
      def create_params
        params.require(:param_template).permit(:name, :use_for, :component_template_id)
      end
    end
  end
end