module Spina
  module Parts
    class Artpiece < Base
      attr_json :artwork_ids, :integer, array: true, default: []

      def content
        Spina::Page.where(view_template: 'artwork', id: artwork_ids)
      end
    end
  end
end
