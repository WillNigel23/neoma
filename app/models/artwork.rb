# == Schema Information
#
# Table name: artworks
#
#  id          :bigint           not null, primary key
#  description :text
#  medium      :string
#  price       :integer
#  size        :string
#  slug        :string
#  status      :integer          default("draft"), not null
#  title       :string           not null
#  year        :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  artist_id   :bigint
#  image_id    :bigint
#
# Indexes
#
#  index_artworks_on_artist_id  (artist_id)
#  index_artworks_on_image_id   (image_id)
#  unique_slug_per_artwork      (title) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (artist_id => artists.id)
#  fk_rails_...  (image_id => images.id)
#
class Artwork < ApplicationRecord

  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :image, class_name: 'Image', optional: true

  belongs_to :artist, optional: true

  has_many :exhibit_artworks, dependent: :nullify
  has_many :exhibits, through: :exhibit_artworks

  validates :title, presence: true, uniqueness: true

  enum status: { draft: 0, live: 1, archived: 2 }

end