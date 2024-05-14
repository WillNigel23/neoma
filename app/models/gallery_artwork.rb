# == Schema Information
#
# Table name: gallery_artworks
#
#  id         :bigint           not null, primary key
#  artwork_id :bigint
#  gallery_id :bigint
#
# Indexes
#
#  index_gallery_artworks                (gallery_id,artwork_id) UNIQUE
#  index_gallery_artworks_on_artwork_id  (artwork_id)
#  index_gallery_artworks_on_gallery_id  (gallery_id)
#
# Foreign Keys
#
#  fk_rails_...  (artwork_id => artworks.id)
#  fk_rails_...  (gallery_id => galleries.id)
#
class GalleryArtwork < ApplicationRecord

  belongs_to :gallery
  belongs_to :artwork

end
