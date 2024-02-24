module Spina
  module Parts
    class FeaturedExhibit < Base
      attr_json :main_exhibit_id, :integer
      attr_json :exhibit_ids, :integer, array: true, default: []

      def content
        [
          Spina::Page.find(view_template: 'exhibit', id: main_exhibit_id),
          Spina::Page.where(view_template: 'exhibit', id: exhibit_ids)
        ]
      end
    end
  end
end
