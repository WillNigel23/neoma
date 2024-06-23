# == Schema Information
#
# Table name: images
#
#  id :bigint           not null, primary key
#
class Image < ApplicationRecord

  has_one_attached :file

  validates :file, presence: true, blob: { content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif'] }

  delegate :attached?, to: :file

  has_many :article_banners, class_name: 'Article', foreign_key: 'banner_id', dependent: :nullify

  has_many :artist_banners, class_name: 'Artist', foreign_key: 'banner_id', dependent: :nullify
  has_many :artist_portraits, class_name: 'Artist', foreign_key: 'portrait_id', dependent: :nullify

  has_many :artwork_images, class_name: 'Artwork', dependent: :nullify

  has_many :content_images, dependent: :destroy
  has_many :content_sections, through: :content_images

  has_many :exhibit_banners, class_name: 'Exhibit', foreign_key: 'banner_id', dependent: :nullify
  has_many :exhibit_posters, class_name: 'Exhibit', foreign_key: 'poster_id', dependent: :nullify

  has_many :gallery_banners, class_name: 'Gallery', foreign_key: 'banner_id', dependent: :nullify

end
