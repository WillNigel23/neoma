# frozen_string_literal: true

module Spina
  module Parts
    class FeaturedArtwork < Base
      attr_json :main_artwork_id, :integer
      attr_json :artwork_ids, :integer, array: true, default: []

      def content
        [
          Spina::Page.find_by(view_template: 'artwork', id: main_artwork_id),
          Spina::Page.where(view_template: 'artwork', id: artwork_ids)
        ]
      end
    end
  end
end
