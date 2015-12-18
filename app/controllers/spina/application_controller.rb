module Spina
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    include ApplicationHelper

    private

    def current_ability
      @current_ability ||= Ability.new(current_user)
    end
    
    def current_user
      @current_user ||= User.where(id: session[:user_id]).first if session[:user_id]
    end
    helper_method :current_user
  end
end
