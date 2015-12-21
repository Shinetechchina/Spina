module Spina
  module Admin
    class AdminController < ApplicationController

      before_filter :authorize_user
      before_filter :new_messages

      layout 'spina/admin/application'

      private

      def authorize_user
        redirect_to "%s%s/%s" % [request.protocol, request.domain, 'admin/login'],  flash: {information: I18n.t('spina.notifications.login')} unless current_user
      end

      def new_messages
        @new_messages = Inquiry.new_messages.sorted
      end

      def current_theme
        @current_theme = Spina.theme(@account.theme) || ::Spina.themes.first
      end
      helper_method :current_theme

      def current_user
        @current_user ||= User.where(id: session[:user_id]).first if session[:user_id]
      end
      helper_method :current_user

    end
  end
end
