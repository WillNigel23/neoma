# == Schema Information
#
# Table name: featured_items
#
#  id               :bigint           not null, primary key
#  featureable_type :string
#  position         :integer          default(0), not null
#  featureable_id   :bigint
#
# Indexes
#
#  index_featured_items_on_featureable  (featureable_type,featureable_id)
#
class FeaturedItem < ApplicationRecord

  belongs_to :featureable, polymorphic: true, optional: true

  validates :position, presence: true

  scope :articles, -> { where(featureable_type: 'Article') }
  scope :artists, -> { where(featureable_type: 'Artist') }
  scope :artworks, -> { where(featureable_type: 'Artwork') }
  scope :exhibits, -> { where(featureable_type: 'Exhibit') }
  scope :galleries, -> { where(featureable_type: 'Gallery') }

end
