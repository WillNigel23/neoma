module V2
  module Admin
    class BaseController < ApplicationController

      layout 'admin/application'

      before_action :authenticate_v2_admin_user!

    end
  end
end
