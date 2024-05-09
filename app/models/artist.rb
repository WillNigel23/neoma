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
#
# Indexes
#
#  unique_slug_per_artist  (name) UNIQUE
#
class Artist < ApplicationRecord

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_one_attached :banner
  has_one_attached :portrait

  has_many :artworks, dependent: :nullify
  has_many :exhibits, -> { distinct }, through: :artworks

  has_many :content_sections, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  enum status: { draft: 0, live: 1, archived: 2 }

end
