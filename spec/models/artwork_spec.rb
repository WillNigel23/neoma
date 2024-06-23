require 'rails_helper'

describe Artwork do
  let(:artwork) { create(:artwork) }

  describe 'fields' do
    describe 'slug' do
      it 'converts title to slug' do
        expect(artwork.title.parameterize).to eq(artwork.slug)
      end

      it 'finds by slug' do
        expect(artwork).to eq(described_class.friendly.find(artwork.slug))
      end
    end

    describe 'image' do
      let(:artwork) { create(:artwork, :with_image) }

      it 'has attached image' do
        expect(artwork.image).not_to be_nil
      end
    end

    describe 'artist' do
      let(:artwork) { create(:artwork, :with_artist) }

      it 'has artist' do
        expect(artwork.artist).not_to be_nil
      end
    end

    describe 'exhibits' do
      let!(:exhibit) { create(:exhibit, artworks: [artwork]) }

      it 'has artist' do
        expect(artwork.exhibits.count).to eq(1)
      end
    end

    describe 'featured_item' do
      let(:artwork) { create(:artwork, :as_featured) }

      it 'has featured_item' do
        expect(artwork.featured_item).not_to be_nil
      end
    end
  end

  describe 'validations' do
    describe 'title' do
      it 'requires title' do
        artwork.title = nil
        expect(artwork).not_to be_valid
      end

      it 'requires unique title' do
        artwork2 = build(:artwork, title: artwork.title)
        expect(artwork2).not_to be_valid
      end
    end
  end
end
