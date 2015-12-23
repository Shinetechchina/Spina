module Spina
  module Admin
    class PagePartsController < AdminController
      before_action :set_account

      def wysihtml5_link
      end

      def insert_wysihtml5_link
      end

      private
      def set_account
        @account = current_user.accounts.friendly.find(params[:account_id])
      end
    end
  end
end