module Spina
  module Admin
    class SessionsController < AdminController
      
      layout "spina/login"

      skip_before_filter :authorize_user

      def new
      end

      def create
        user = User.where(email: params[:email]).first
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          session[:domain] = request.domain
          user.update_last_logged_in!
          redirect_to "%s%s/%s" % [request.protocol, request.domain, 'admin']
        else
          flash.now[:alert] = I18n.t('spina.notifications.wrong_username_or_password')
          render "new"
        end
      end

      def destroy
        session[:user_id] = nil
        redirect_to admin_root_path
      end
    end  
  end
end
