module Spina
  module Parts
    class Artpiece < Base
      attr_json :artwork_ids, :integer, array: true, default: []

      def content
        artpiece_collection = []

        pages = Spina::Resource.where(name: 'artworks', id: artwork_ids).first&.pages

        pages&.each do |p|
          artpiece_collection << [p.id, p.content(:header)]
        end

        artpiece_collection
      end
    end
  end
end
