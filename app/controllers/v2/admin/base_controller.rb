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

      def nested_content_sections_update_callback(required_class)
        permitted_params = params.require(required_class).permit(
          content_sections_attributes: [:id, :_destroy, { image_ids: [] }]
        )

        content_sections_params = permitted_params[:content_sections_attributes].to_h

        content_sections_params.each do |(_, attributes)|
          cs = ContentSection.find_by(id: attributes[:id])

          next if cs.nil?

          if attributes[:_destroy] == 'false'
            cs.content_images.destroy_all

            attributes[:image_ids]&.each_with_index do |image_id, position|
              cs.content_images.create(image_id:, position:)
            end
          else
            cs.destroy
          end
        end
      end

      def redirect_to_type_map
        {
          homepage: v2_admin_root_path,
          exhibits: v2_admin_exhibits_path,
          artworks: v2_admin_artworks_path,
          artists: v2_admin_artists_path,
          articles: v2_admin_articles_path,
          galleries: v2_admin_galleries_path
        }
      end

    end
  end
end
