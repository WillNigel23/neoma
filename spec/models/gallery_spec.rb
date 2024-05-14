require 'rails_helper'

describe Gallery do
  let(:gallery) { create(:gallery) }

  describe 'fields' do
    describe 'slug' do
      it 'converts title to slug' do
        expect(gallery.title.parameterize).to eq(gallery.slug)
      end

      it 'finds by slug' do
        expect(gallery).to eq(described_class.friendly.find(gallery.slug))
      end
    end

    describe 'images' do
      let(:gallery) { create(:gallery, :with_banner) }

      it 'has attached banner' do
        expect(gallery.banner).not_to be_nil
      end
    end

    describe 'artworks' do
      let(:gallery) { create(:gallery, :with_artworks) }

      it 'has artworks' do
        expect(gallery.artworks.count).to eq(1)
      end
    end

    describe 'artists' do
      let!(:artwork) { create(:artwork, :with_artist) }
      let!(:gallery) { create(:gallery, artworks: [artwork]) }

      it 'has artists' do
        expect(gallery.artists.count).to eq(1)
      end
    end

    describe 'content_sections' do
      let(:gallery) { create(:gallery, :with_content_sections) }

      it 'has content sections' do
        expect(gallery.content_sections.count).to eq(1)
      end
    end
  end

  describe 'validations' do
    describe 'title' do
      it 'requires title' do
        gallery.title = nil
        expect(gallery).not_to be_valid
      end

      it 'requires unique title' do
        gallery2 = build(:gallery, title: gallery.title)
        expect(gallery2).not_to be_valid
      end
    end
  end
end
