require 'rails_helper'

describe FeaturedItem do
  let(:featured_item) { create(:featured_item) }

  describe 'fields' do
    describe 'position' do
      it 'has position' do
        expect(featured_item.position).not_to be_nil
      end
    end
  end

  describe 'scopes' do
    let(:article) { create(:article, :as_featured) }
    let(:artist) { create(:artist, :as_featured) }
    let(:artwork) { create(:artwork, :as_featured) }
    let(:exhibit) { create(:exhibit, :as_featured) }
    let(:gallery) { create(:gallery, :as_featured) }

    it 'by articles' do
      result = FeaturedItem.articles
      expect(result).to contain_exactly(article.featured_item)
    end

    it 'by artists' do
      result = FeaturedItem.artists
      expect(result).to contain_exactly(artist.featured_item)
    end

    it 'by artworks' do
      result = FeaturedItem.artworks
      expect(result).to contain_exactly(artwork.featured_item)
    end

    it 'by exhibits' do
      result = FeaturedItem.exhibits
      expect(result).to contain_exactly(exhibit.featured_item)
    end

    it 'by galleries' do
      result = FeaturedItem.galleries
      expect(result).to contain_exactly(gallery.featured_item)
    end
  end
end
