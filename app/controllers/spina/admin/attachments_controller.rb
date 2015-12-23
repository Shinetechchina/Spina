module Spina
  module Admin
    class AttachmentsController < AdminController
      before_filter :set_account
      before_filter :set_breadcrumbs

      authorize_resource class: Attachment

      layout "spina/admin/media_library"

      def index
        add_breadcrumb I18n.t('spina.website.documents'), spina.admin_account_attachments_path(@account)
        @attachments = @account.attachments.file_attached.sorted
        @attachment = Attachment.new
      end

      def create
        @attachment = @account.attachments.create(attachment_params)
      end

      def destroy
        @attachment = Attachment.find(params[:id])
        @attachment.destroy
        redirect_to spina.admin_account_attachments_path(@account)
      end

      def select
        @attachments = Attachment.file_attached.sorted
        @attachment = Attachment.new
      end

      def insert
        @attachment = Attachment.find(params[:attachment_id])
      end

      def select_collection
        @attachments = Attachment.file_attached.sorted
        @attachment = Attachment.new
      end

      def insert_collection
        @attachments = Attachment.find(params[:attachment_ids])
      end

      private

      def set_account
        @account = current_user.accounts.friendly.find(params[:account_id])
      end

      def set_breadcrumbs
        add_breadcrumb I18n.t('spina.website.media_library'), spina.admin_account_media_library_path(@account)
      end

      def attachment_params
        params.require(:attachment).permit(:file, :page_id, :_destroy)
      end
    end
  end
end
