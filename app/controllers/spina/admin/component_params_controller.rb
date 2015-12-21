module Spina
  module Admin
    class ComponentParamsController < AdminController
      before_action :is_page_params_exist?
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
      def destroy
        ComponentParam.find_by(id: params[:id]).try(:destroy)
        redirect_to :back
      end
      private
      def update_params
        params.require(:component_param).permit(:id, :name, :use_for, :component_id)
      end
      def create_params
        params.require(:component_param).permit(:name, :use_for, :component_id)
      end
      def is_page_params_exist?
        case params["action"]
          when "destroy"
            component_param = ComponentParam.find_by(id: params[:id])
            redirect_to :back, notice: I18n.t('spina.notifications.modify_component_failed') and return if component_param.present? && component_param.page_component_params.present?
          when "new"
            component_id = params[:component_id]
          when "create"
            component_id = create_params[:component_id]
          when "update"
            component_id = update_params[:component_id]
        end
        if Component.find(component_id).component_params.any?{|c| c.page_component_params.any?}
          redirect_to :back, notice: I18n.t('spina.notifications.modify_component_failed')
        end
      end
    end
  end
end
