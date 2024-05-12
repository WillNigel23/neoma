# == Schema Information
#
# Table name: content_images
#
#  id                 :bigint           not null, primary key
#  content_section_id :bigint
#  image_id           :bigint
#
# Indexes
#
#  index_content_images_on_content_section_id  (content_section_id)
#  index_content_images_on_image_id            (image_id)
#
# Foreign Keys
#
#  fk_rails_...  (content_section_id => content_sections.id)
#  fk_rails_...  (image_id => images.id)
#
class ContentImage < ApplicationRecord

  belongs_to :image, class_name: 'Image'
  belongs_to :content_section, class_name: 'ContentSection'

end
