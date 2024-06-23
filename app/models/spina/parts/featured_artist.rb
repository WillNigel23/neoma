module Spina
  module Parts
    class FeaturedArtist < Base

      attr_json :main_artist_id, :integer
      attr_json :artist_ids, :integer, array: true, default: []

      def content
        [
          Spina::Page.find_by(view_template: 'artist', id: main_artist_id),
          Spina::Page.where(view_template: 'artist', id: artist_ids)
        ]
      end

    end
  end
end
