# == Schema Information
#
# Table name: galleries
#
#  id          :bigint           not null, primary key
#  description :text
#  location    :string
#  slug        :string
#  status      :integer          default("draft"), not null
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  banner_id   :bigint
#
# Indexes
#
#  index_galleries_on_banner_id  (banner_id)
#  unique_slug_per_gallery       (title) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (banner_id => images.id)
#
class Gallery < ApplicationRecord

  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :banner, class_name: 'Image', optional: true

  has_many :gallery_artworks, dependent: :destroy
  has_many :artworks, through: :gallery_artworks
  has_many :artists, -> { distinct }, through: :artworks, source: :artist

  has_many :content_sections, as: :contentable, dependent: :destroy
  has_one :featured_item, as: :featureable, dependent: :destroy

  validates :title, presence: true, uniqueness: true

  enum status: { draft: 0, live: 1, archived: 2 }

end
