module Spina
  module Admin
    class MailinglistsController < AdminController

      admin_section :inbox

      def index
        @mails = Mailinglist.order(:email)
        add_breadcrumb I18n.t('spina.inbox.email_list'), spina.admin_mailinglists_path
      end

      def new
        @mail = Mailinglist.new

        add_index_breadcrumb
        add_breadcrumb I18n.t('spina.mailinglists.new')
      end

      def edit
        @mail = Mailinglist.find(params[:id])
        add_index_breadcrumb
        add_breadcrumb I18n.t('spina.mailinglists.edit')
      end

      def create
        @mail = Mailinglist.new(mail_params)
        if @mail.save
          redirect_to admin_mailinglists_url
        else
          flash.now[:alert] = I18n.t('spina.mailinglists.cannot_be_created')
          add_index_breadcrumb
          add_breadcrumb I18n.t('spina.mailinglists.new')
          render :new, status: :unprocessable_entity
        end
      end

      def update
      end

      def destroy
        @mail = Mailinglist.find(params[:id])
        @mail.destroy
        redirect_to spina.admin_mailinglists_url, flash: { success: t('spina.mailinglists.deleted') }
      end

      private

      def add_index_breadcrumb
        add_breadcrumb I18n.t('spina.inbox.email_list'), spina.admin_mailinglists_path, class: 'text-gray-400'
      end

      def mail_params
        params.require(:mailinglist).permit(:email)
      end

    end
  end
end
