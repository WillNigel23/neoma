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
require 'rails_helper'

describe ContentSection do
  let(:content_section) { create(:content_section) }

  describe 'fields' do
    describe 'images' do
      let(:content_section) { create(:content_section, :with_images) }

      it 'has attached images' do
        expect(content_section.images.attached?).to be true
      end
    end
  end

  describe 'validations' do
    describe 'no content' do
      it 'requires at least image, header or content' do
        content_section.header = nil
        content_section.content = nil
        expect(content_section).not_to be_valid
      end
    end
  end
end
