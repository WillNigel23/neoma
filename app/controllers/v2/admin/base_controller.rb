module V2
  module Admin
    class BaseController < ApplicationController

      layout 'admin/application'

      before_action :authenticate_v2_admin_user!
      before_action :authorize_v2_admin_user

      private

      def authorize_v2_admin_user
        return if current_v2_admin_user.role == 'admin' || current_v2_admin_user.role == 'super_admin'

        @flash = [[:error, I18n.t('errors.unauthorized')]]
        redirect_to v2_root_path
      end

    end
  end
end
