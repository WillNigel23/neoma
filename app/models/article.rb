# == Schema Information
#
# Table name: articles
#
#  id          :bigint           not null, primary key
#  date        :date             not null
#  description :text
#  slug        :string
#  status      :integer          default("draft"), not null
#  subtitle    :string
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  banner_id   :bigint
#
# Indexes
#
#  index_articles_on_banner_id  (banner_id)
#  unique_slug_per_article      (title) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (banner_id => images.id)
#
class Article < ApplicationRecord

  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :banner, class_name: 'Image', optional: true

  has_many :content_sections, as: :contentable, dependent: :destroy

  has_one :featured_item, as: :featureable, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :date, presence: true

  enum status: { draft: 0, live: 1, archived: 2 }

end
