module Spina
  module Admin
    class MailinglistsController < AdminController
      admin_section :inbox

      def index
        add_breadcrumb I18n.t("spina.preferences.users"), spina.admin_users_path
      end

    end
  end
end
