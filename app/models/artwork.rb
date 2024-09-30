# == Schema Information
#
# Table name: artworks
#
#  id          :bigint           not null, primary key
#  description :text
#  medium      :string
#  price       :integer
#  sale_status :integer          default("available"), not null
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

  has_many :exhibit_artworks, dependent: :destroy
  has_many :exhibits, through: :exhibit_artworks

  has_many :gallery_artworks, dependent: :destroy
  has_many :galleries, through: :gallery_artworks

  has_one :featured_item, as: :featureable, dependent: :destroy

  validates :title, presence: true, uniqueness: true

  enum status: { draft: 0, live: 1, archived: 2 }
  enum sale_status: { available: 0, reserved: 1, sold: 2 }

  ATTRIBUTES = [
    :slug,
    :title,
    :size,
    :medium,
    :price,
    :year,
    :status,
    :sale_status,
    :description,
    :image,
    :artist
  ]

  SORTING_PARAMS = {
    title: 'title ASC',
    artist: 'artists.name ASC',
    price_asc: 'price ASC',
    price_desc: 'price DESC',
    year: 'year ASC'
  }

end
