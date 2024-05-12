require 'rails_helper'

describe ContentSection do
  let(:content_section) { create(:content_section) }

  describe 'fields' do
    describe 'images' do
      let(:content_section) { create(:content_section, :with_images, :skip_validate_to_create) }

      it 'has attached images' do
        expect(content_section.images.any?).to be true
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
