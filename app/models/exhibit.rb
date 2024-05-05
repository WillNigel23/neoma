# frozen_string_literal: true

# == Schema Information
#
# Table name: exhibits
#
#  id         :bigint           not null, primary key
#  end_date   :date
#  slug       :string
#  start_date :date             not null
#  status     :integer          default("draft"), not null
#  subtitle   :string
#  summary    :text
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  unique_slug_per_exhibit  (title) UNIQUE
#
class Exhibit < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_one_attached :banner
  has_one_attached :poster

  has_many :exhibit_artworks, dependent: :nullify
  has_many :artworks, through: :exhibit_artworks
  has_many :artists, -> { distinct }, through: :artworks, source: :artist

  validates :title, presence: true, uniqueness: true
  validates :start_date, presence: true
  validates :end_date, comparison: {
    greater_than_or_equal_to: :start_date,
    message: I18n.t('errors.exhibits.invalid_dates')
  }, allow_blank: true

  enum status: { draft: 0, live: 1, archived: 2 }

  scope :past, lambda {
    where('end_date < :date', date: Date.current)
  }

  scope :ongoing, lambda {
    where('start_date <= :date AND (end_date IS NULL OR end_date >= :date)', date: Date.current)
  }

  scope :future, lambda {
    where('start_date > :date', date: Date.current)
  }
end
