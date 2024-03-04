# frozen_string_literal: true

module Spina
  module Parts
    class FeaturedGallery < Base
      attr_json :main_gallery_id, :integer
      attr_json :gallery_ids, :integer, array: true, default: []

      def content
        [
          Spina::Page.find_by(view_template: 'gallery', id: main_gallery_id),
          Spina::Page.where(view_template: 'gallery', id: gallery_ids)
        ]
      end
    end
  end
end
