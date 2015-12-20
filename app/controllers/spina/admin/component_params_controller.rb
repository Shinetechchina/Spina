module Spina
  module Admin
    class ComponentParamsController < AdminController

      def destroy
        ComponentParam.find_by(id: params[:id]).try(:destroy)
        redirect_to :back
      end

      def new
        @component = Component.find(params[:component_id])
        @component_param = @component.component_params.build(id: Time.now.to_i)
      end

      def create
        ComponentParam.create(create_params)
        redirect_to :back
      end

      def update
        ComponentParam.update(params[:id], update_params)
        redirect_to :back
      end

      private
      def update_params
        params.require(:component_param).permit(:id, :name, :use_for, :component_id)
      end
      def create_params
        params.require(:component_param).permit(:name, :use_for, :component_id)
      end
    end
  end
end
