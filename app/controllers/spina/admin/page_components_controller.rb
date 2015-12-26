module Spina
  module Admin
    class PageComponentsController < AdminController
      before_action :set_account
      before_action :set_page
      before_action :set_page_component, only: [:edit, :update, :destroy]
      before_action :set_breadcrumb

      layout "spina/admin/website"

      def new
        add_breadcrumb I18n.t('spina.pages_components.new', default: 'add component')

        @page_component = @page.page_components.new
      end

      def create
        @page_component = @page.page_components.new(create_params)

        if @page_component.save
          redirect_to spina.edit_admin_account_page_page_component_path(@account, @page, @page_component)
        else
          render :new
        end
      end

      def edit
        add_breadcrumb @page_component.name, spina.edit_admin_account_page_path(@account, @page)
        add_breadcrumb I18n.t('spina.pages_components.set_value', default: 'set_value')
      end

      def update
        if @page_component.update_attributes(update_params)
          redirect_to spina.edit_admin_account_page_path(@account, @page)
        else
          render :edit
        end
      end

      def destroy
        @page_component.destroy

        redirect_to spina.edit_admin_account_page_path(@account, @page)
      end

      private
      def set_account
        @account = current_user.accounts.friendly.find(params[:account_id])
      end

      def set_page
        @page = @account.pages.friendly.find(params[:page_id])
      end

      def set_page_component
        @page_component = @page.page_components.find(params[:id])
      end

      def set_breadcrumb
        add_breadcrumb I18n.t('spina.website.pages'), spina.admin_account_pages_path(@account)
        add_breadcrumb @page.title, spina.edit_admin_account_page_path(@account, @page)
      end

      def create_params
        params[:page_component] ||= {_: 0}
        
        params.require(:page_component).permit(:component_id)
      end
      def update_params
        params[:page_component] ||= {_: 0}

        params.require(:page_component).permit(:component_id, page_component_params_attributes: [:id, :component_param_id, :param_value])
      end
    end
  end
end
