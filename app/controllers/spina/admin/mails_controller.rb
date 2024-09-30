module Spina
  module Admin
    class MailsController < AdminController

      admin_section :inbox

      def index
        @inquiries = Mail.all
        add_breadcrumb I18n.t('spina.inbox.inquiries'), spina.admin_mails_path
      end

      def show
        @inquiry = Mail.find(params[:id])
        if @inquiry.artwork_id
          @artwork = Artwork.find_by(id: @inquiry.artwork_id)
          @spina_artwork = @inquiry.artwork_id ? Page.find(@inquiry.artwork_id) : nil
        end

        add_index_breadcrumb
        add_breadcrumb I18n.t('spina.inquiries.show'), spina.admin_mails_path
      end

      def destroy
        @inquiry = Mail.find(params[:id])
        @inquiry.destroy
        redirect_to spina.admin_mails_url, flash: { success: t('spina.mailinglists.deleted') }
      end

      private

      def add_index_breadcrumb
        add_breadcrumb I18n.t('spina.inbox.inquiries'), spina.admin_mails_path, class: 'text-gray-400'
      end

    end
  end
end
