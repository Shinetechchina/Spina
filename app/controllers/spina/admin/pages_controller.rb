module Spina
  module Admin
    class PagesController < AdminController

      before_action :set_account
      before_filter :set_breadcrumb
      before_filter :set_tabs, only: [:new, :create, :edit, :update]
      before_action :set_theme

      authorize_resource class: Page

      layout "spina/admin/website"

      def index
        @pages = @account.pages.sorted.roots
      end

      def new
        @page = @account.pages.new
        if @theme.new_page_templates.any? { |template| template[0] == params[:view_template] }
          @page.view_template = params[:view_template]
        end
        add_breadcrumb I18n.t('spina.pages.new')
        @page_parts = @theme.config.page_parts.map { |page_part| @page.page_part(page_part) }
      end

      def create
        @page = @account.pages.new(page_params)
        add_breadcrumb I18n.t('spina.pages.new')
        if @page.save
          redirect_to spina.edit_admin_account_page_path(@account, @page)
        else
          @page_parts = @page.page_parts
          render :new
        end
      end

      def edit
        @page = @account.pages.find(params[:id])
        add_breadcrumb @page.title
        @page_parts = @theme.config.page_parts.map { |page_part| @page.page_part(page_part) }
      end

      def update
        @page = @account.pages.find(params[:id])
        add_breadcrumb @page.title
        respond_to do |format|
          if @page.update_attributes(page_params)
            format.html { redirect_to spina.edit_admin_account_page_path(@account, @page) }
            format.js
          else
            format.html do
              @page_parts = @page.page_parts
              render :edit
            end
          end
        end
      end

      def sort
        params[:list].each_pair do |parent_pos, parent_node|
          if parent_node[:children].present?
            parent_node[:children].each_pair do |child_pos, child_node|
              child_node[:children].each_pair { |grand_child_pos, grand_child| update_page_position(grand_child, grand_child_pos, child_node[:id]) } if child_node[:children].present?
              update_page_position(child_node, child_pos, parent_node[:id])
            end
          end
          update_page_position(parent_node, parent_pos, nil)
        end
        render nothing: true
      end

      def destroy
        @page = @account.pages.find(params[:id])

        @page.destroy
        redirect_to spina.admin_account_pages_path(@account)
      end

      private

      def set_theme
        @theme = Spina.theme(@account.theme) || ::Spina.themes.first
      end

      def set_account
        @account = current_user.accounts.friendly.find(params[:account_id])
      end

      def set_breadcrumb
        add_breadcrumb I18n.t('spina.website.pages'), spina.admin_account_pages_path(@account)
      end

      def set_tabs
        @tabs = %w{page_content page_seo advanced}
      end

      def update_page_position(page, position, parent_id = nil)
        Page.update(page[:id], position: position.to_i + 1, parent_id: parent_id )
      end

      def page_params
        params.require(:page).permit!
      end

    end
  end
end
