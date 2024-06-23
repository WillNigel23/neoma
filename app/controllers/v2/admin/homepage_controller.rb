module V2
  module Admin
    class HomepageController < BaseController

      def index
        @exhibits = FeaturedItem.exhibits.order(position: :asc)
        @artworks = FeaturedItem.artworks.order(position: :asc)
        @artists = FeaturedItem.artists.order(position: :asc)
        @articles = FeaturedItem.articles.order(position: :asc)
        @galleries = FeaturedItem.galleries.order(position: :asc)
      end

      def set_featured_items
        featureable_type = params[:featureable_type]

        original_featureable_ids = FeaturedItem.where(featureable_type:).pluck(:featureable_id)

        params[:featured_item][:featureable_id].each_with_index do |item, index|
          next if item.blank?

          featured_item = FeaturedItem.find_or_create_by(featureable_id: item, featureable_type:)

          featured_item.update!(position: index)
        end

        params[:featured_item][:_destroy].each do |item|
          FeaturedItem.find_by(featureable_id: item, featureable_type:)&.destroy
        end

        original_featureable_ids.each do |id|
          FeaturedItem.find_by(featureable_id: id, featureable_type:)&.destroy unless
            params[:featured_item][:featureable_id]&.include?(id.to_s)
        end

        flash[:notice] = "Updated Featured #{featureable_type} successfully"
        redirect_to v2_admin_homepage_index_path(active_tab: params[:active_tab])
      end

    end
  end
end
