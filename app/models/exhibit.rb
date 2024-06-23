# == Schema Information
#
# Table name: exhibits
#
#  id          :bigint           not null, primary key
#  description :text
#  end_date    :date
#  slug        :string
#  start_date  :date             not null
#  status      :integer          default("draft"), not null
#  subtitle    :string
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  banner_id   :bigint
#  poster_id   :bigint
#
# Indexes
#
#  index_exhibits_on_banner_id  (banner_id)
#  index_exhibits_on_poster_id  (poster_id)
#  unique_slug_per_exhibit      (title) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (banner_id => images.id)
#  fk_rails_...  (poster_id => images.id)
#
class Exhibit < ApplicationRecord

  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :banner, class_name: 'Image', optional: true
  accepts_nested_attributes_for :banner, allow_destroy: false
  belongs_to :poster, class_name: 'Image', optional: true
  accepts_nested_attributes_for :poster, allow_destroy: false

  has_many :exhibit_artworks, dependent: :destroy
  has_many :artworks, through: :exhibit_artworks
  has_many :artists, -> { distinct }, through: :artworks, source: :artist

  has_many :content_sections, as: :contentable, dependent: :destroy
  accepts_nested_attributes_for :content_sections, allow_destroy: false
  has_one :featured_item, as: :featureable, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :start_date, presence: true
  validates :end_date, comparison: {
    greater_than_or_equal_to: :start_date,
    message: I18n.t('errors.exhibits.invalid_dates')
  }, allow_blank: true

  enum status: { draft: 0, live: 1, archived: 2 }

  scope :past, -> {
    where('end_date < :date', date: Date.current)
  }

  scope :ongoing, -> {
    where('start_date <= :date AND (end_date IS NULL OR end_date >= :date)', date: Date.current)
  }

  scope :future, -> {
    where('start_date > :date', date: Date.current)
  }

  before_destroy :nullify_images

  private

  def nullify_images
    update(banner_id: nil)
    update(poster_id: nil)
  end

end
