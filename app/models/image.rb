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

end
