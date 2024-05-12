# == Schema Information
#
# Table name: artists
#
#  id          :bigint           not null, primary key
#  description :string
#  full_name   :string
#  name        :string           not null
#  role        :string
#  slug        :string
#  status      :integer          default("draft"), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  banner_id   :bigint
#  portrait_id :bigint
#
# Indexes
#
#  index_artists_on_banner_id    (banner_id)
#  index_artists_on_portrait_id  (portrait_id)
#  unique_slug_per_artist        (name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (banner_id => images.id)
#  fk_rails_...  (portrait_id => images.id)
#
class Artist < ApplicationRecord

  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :banner, class_name: 'Image', optional: true
  belongs_to :portrait, class_name: 'Image', optional: true

  has_many :artworks, dependent: :nullify
  has_many :exhibits, -> { distinct }, through: :artworks

  has_many :content_sections, as: :contentable, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  enum status: { draft: 0, live: 1, archived: 2 }

end
