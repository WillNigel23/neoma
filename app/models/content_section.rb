# == Schema Information
#
# Table name: content_sections
#
#  id         :bigint           not null, primary key
#  header     :string
#  artist_id  :bigint
#  exhibit_id :bigint
#
# Indexes
#
#  index_content_sections_on_artist_id   (artist_id)
#  index_content_sections_on_exhibit_id  (exhibit_id)
#
# Foreign Keys
#
#  fk_rails_...  (artist_id => artists.id)
#  fk_rails_...  (exhibit_id => exhibits.id)
#
class ContentSection < ApplicationRecord

  belongs_to :artist, optional: true
  belongs_to :exhibit, optional: true

  has_rich_text :content
  has_many_attached :images

  validate :has_valid_contents

  private

  def has_valid_contents
    return unless images.empty? && content.body.nil? && header.blank?

    errors.add(:header, :no_value, message: I18n.t('errors.content_sections.no_value'))
  end

end
