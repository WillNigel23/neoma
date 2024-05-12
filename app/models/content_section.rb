# == Schema Information
#
# Table name: content_sections
#
#  id               :bigint           not null, primary key
#  contentable_type :string
#  header           :string
#  contentable_id   :bigint
#
# Indexes
#
#  index_content_sections_on_contentable  (contentable_type,contentable_id)
#
class ContentSection < ApplicationRecord

  belongs_to :contentable, polymorphic: true, optional: true

  has_many :content_images, dependent: :destroy
  has_many :images, through: :content_images

  has_rich_text :content

  validate :has_valid_contents

  private

  def has_valid_contents
    return unless images.empty? && content.body.nil? && header.blank?

    errors.add(:header, :no_value, message: I18n.t('errors.content_sections.no_value'))
  end

end
