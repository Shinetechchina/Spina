module Spina
  class BaseController < ApplicationController
    before_action :set_subdomain

    private
    def set_subdomain
      @subdomain = request.subdomain

      return redirect_to admin_root_path if @subdomain.blank?
      @subdomain
    end

    def current_account

      @current_account = Account.find_by(subdomain: @subdomain)
      raise ActiveRecord::RecordNotFound if @current_account.blank?

      @current_account
    end
    helper_method :current_account

    def current_theme
      @current_theme = Spina.theme(current_account.theme) || ::Spina.themes.first
    end
    helper_method :current_theme

  end
end
