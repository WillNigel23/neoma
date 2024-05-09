# == Schema Information
#
# Table name: exhibit_artists
#
#  id         :bigint           not null, primary key
#  artist_id  :bigint
#  exhibit_id :bigint
#
# Indexes
#
#  index_exhibit_artists                (exhibit_id,artist_id) UNIQUE
#  index_exhibit_artists_on_artist_id   (artist_id)
#  index_exhibit_artists_on_exhibit_id  (exhibit_id)
#
# Foreign Keys
#
#  fk_rails_...  (artist_id => artists.id)
#  fk_rails_...  (exhibit_id => exhibits.id)
#
class ExhibitArtist < ApplicationRecord

  belongs_to :exhibit
  belongs_to :artist

end
