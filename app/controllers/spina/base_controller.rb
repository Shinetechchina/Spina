module Spina
  class BaseController < ApplicationController
    private
    def current_account
      @current_account = Account.find_by(subdomain: request.subdomain)
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
