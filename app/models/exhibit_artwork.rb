
# == Schema Information
#
# Table name: exhibit_artworks
#
#  id         :bigint           not null, primary key
#  artwork_id :bigint
#  exhibit_id :bigint
#
# Indexes
#
#  index_exhibit_artworks                (exhibit_id,artwork_id) UNIQUE
#  index_exhibit_artworks_on_artwork_id  (artwork_id)
#  index_exhibit_artworks_on_exhibit_id  (exhibit_id)
#
# Foreign Keys
#
#  fk_rails_...  (artwork_id => artworks.id)
#  fk_rails_...  (exhibit_id => exhibits.id)
#
class ExhibitArtwork < ApplicationRecord
  belongs_to :exhibit
  belongs_to :artwork
end
