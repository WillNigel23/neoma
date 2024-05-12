require 'rails_helper'

describe Image do
  let(:image) { create(:image) }

  describe 'fields' do
    describe 'file' do
      let(:image) { create(:image, :as_banner) }

      it 'has attached file' do
        expect(image.file.attached?).to be true
      end
    end
  end

  describe 'validations' do
    describe 'file' do
      it 'requires file' do
        image2 = build(:image)
        expect(image2).not_to be_valid
      end
    end
  end
end
