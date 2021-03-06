module Spina
  module Admin
    class AccountsController < AdminController

      before_filter :check_account_valid, except: [:new, :create]
      authorize_resource class: Account
      layout "spina/admin/settings"
      before_action :set_account, except: [:new, :index, :create]

      def index
        @accounts = current_user.accounts
        add_breadcrumb I18n.t('spina.accounts.index', default: 'websites')
        
        render layout: "spina/admin/account"
      end

      def new
        @account = Account.new
        add_breadcrumb I18n.t('spina.accounts.new')

        render layout: "spina/admin/account"
      end

      def create
        @account = Account.new(account_params)
        if @account.save
          current_user.accounts << @account
          redirect_to spina.admin_account_pages_path(@account)
        else
          add_breadcrumb I18n.t('spina.accounts.new')
          render :new, layout: "spina/admin/account"
        end
      end

      def edit
        add_breadcrumb I18n.t('spina.preferences.account'), spina.edit_admin_account_path(@account)
      end

      def update
        if @account.update_attributes(account_params)
          return redirect_to spina.edit_admin_account_path(@account) if account_params[:name].present?

          redirect_to :back
        else
          return render :edit if account_params[:name].present?

          redirect_to :back
        end
      end

      def destroy
        @account.destroy

        redirect_to spina.admin_accounts_path
      end

      def analytics
        add_breadcrumb I18n.t('spina.preferences.analytics'), spina.analytics_admin_account_path
      end

      def social
        add_breadcrumb I18n.t('spina.preferences.social_media'), spina.social_admin_account_path
      end

      def aviary
        add_breadcrumb I18n.t('spina.preferences.aviary'), spina.aviary_admin_account_path
      end

      def style
        add_breadcrumb I18n.t('spina.preferences.style'), spina.style_admin_account_path
        @themes = ::Spina.themes
        @layout_parts = current_theme.config.layout_parts.map { |layout_part| @account.layout_part(layout_part) }
      end

      private

      def set_account
        @account = current_user.accounts.friendly.find(params[:id])
      end

      def check_account_valid
        unless current_user.account_active?
          redirect_to spina.new_admin_account_path
        end
      end

      def account_params
        params.require(:account).permit(:address, :city, :email, :logo, :name, :phone,
                                        :postal_code, :preferences, :google_analytics,
                                        :google_site_verification, :facebook, :twitter, :google_plus,
                                        :aviary_api_key, :aviary_language, :ngrok_address,
                                        :kvk_identifier, :theme, :vat_identifier, :robots_allowed,
                                        :subdomain, :custom_domain,
                                        layout_parts_attributes:
                                          [:id, :layout_partable_type, :layout_partable_id,
                                            :name, :title, :position, :content, :page_id,
                                            layout_partable_attributes:
                                              [:content, :photo_tokens, :attachment_tokens, :id]])
      end
    end
  end
end
