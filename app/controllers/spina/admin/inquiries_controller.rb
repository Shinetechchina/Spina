module Spina
  module Admin
    class InquiriesController < AdminController

      authorize_resource class: Inquiry

      before_action :set_account
      before_filter :set_inquiry, except: [:index, :inbox, :spam]

      layout "spina/admin/messages"

      def show
        add_breadcrumb I18n.t('spina.inquiries.all'), spina.admin_account_inquiries_path(@account)
        add_breadcrumb @inquiry.name
      end

      def inbox_show
        add_breadcrumb I18n.t('spina.inquiries.inbox'), spina.inbox_admin_account_inquiries_path(@account)
        add_breadcrumb @inquiry.name
        render :show
      end

      def index
        add_breadcrumb I18n.t('spina.inquiries.all'), spina.admin_account_inquiries_path(@account)
        @inquiries = @account.inquiries.sorted
      end

      def inbox
        add_breadcrumb I18n.t('spina.inquiries.inbox'), spina.inbox_admin_account_inquiries_path(@account)
        @inquiries = @account.inquiries.new_messages.sorted
      end

      def spam
        add_breadcrumb I18n.t('spina.inquiries.all'), spina.admin_account_inquiries_path(@account)
        add_breadcrumb I18n.t('spina.inquiries.spam'), spina.spam_admin_account_inquiries_path(@account)
        @inquiries = @account.inquiries.spam.order('created_at DESC')
      end

      def mark_as_read
        @inquiry.update_attribute(:archived, true)
        redirect_to spina.inbox_admin_account_inquiries_path(@account)
      end

      def unmark_spam
        @inquiry.ham!
        redirect_to spina.admin_account_inquiries_path(@account)
      end

      def destroy
        @inquiry.destroy
        redirect_to spina.admin_account_inquiries_path(@account)
      end

      private

      def set_account
        @account = current_user.accounts.friendly.find(params[:account_id])
      end

      def set_inquiry        
        @inquiry = @account.inquiries.find(params[:id])
      end

      def inquiry_params
        params.require(:inquiry).permit(:archived, :email, :message, :name, :phone)
      end
    end
  end
end
