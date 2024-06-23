require 'rails_helper'

describe Exhibit do
  let(:exhibit) { create(:exhibit) }

  describe 'fields' do
    describe 'slug' do
      it 'converts title to slug' do
        expect(exhibit.title.parameterize).to eq(exhibit.slug)
      end

      it 'finds by slug' do
        expect(exhibit).to eq(described_class.friendly.find(exhibit.slug))
      end
    end

    describe 'images' do
      let(:exhibit) { create(:exhibit, :with_banner, :with_poster) }

      it 'has attached banner' do
        expect(exhibit.banner).not_to be_nil
      end

      it 'has attached poster' do
        expect(exhibit.poster).not_to be_nil
      end
    end

    describe 'artworks' do
      let(:exhibit) { create(:exhibit, :with_artworks) }

      it 'has artworks' do
        expect(exhibit.artworks.count).to eq(1)
      end
    end

    describe 'artists' do
      let!(:artwork) { create(:artwork, :with_artist) }
      let!(:exhibit) { create(:exhibit, artworks: [artwork]) }

      it 'has artists' do
        expect(exhibit.artists.count).to eq(1)
      end
    end

    describe 'content_sections' do
      let(:exhibit) { create(:artist, :with_content_sections) }

      it 'has content sections' do
        expect(exhibit.content_sections.count).to eq(1)
      end
    end
  end

  describe 'validations' do
    describe 'title' do
      it 'requires title' do
        exhibit.title = nil
        expect(exhibit).not_to be_valid
      end

      it 'requires unique title' do
        exhibit2 = build(:exhibit, title: exhibit.title)
        expect(exhibit2).not_to be_valid
      end
    end

    describe 'date' do
      it 'requires start_date' do
        exhibit.start_date = nil
        expect(exhibit).not_to be_valid
      end

      it 'requires start_date < end_date' do
        exhibit.end_date = exhibit.start_date - 1.day
        expect(exhibit).not_to be_valid
      end
    end
  end

  describe 'scopes' do
    let(:exhibit_1) { create(:exhibit, start_date: 10.days.ago, end_date: 5.days.ago, status: :archived) }
    let(:exhibit_2) { create(:exhibit, start_date: Date.current, status: :live) }
    let(:exhibit_3) { create(:exhibit, start_date: 10.days.from_now, status: :draft) }

    it 'by status' do
      result = Exhibit.archived
      expect(result).to contain_exactly(exhibit_1)

      result = Exhibit.live
      expect(result).to contain_exactly(exhibit_2)

      result = Exhibit.draft
      expect(result).to contain_exactly(exhibit_3)
    end

    it 'by past' do
      result = Exhibit.past
      expect(result).to contain_exactly(exhibit_1)

      result = Exhibit.ongoing
      expect(result).to contain_exactly(exhibit_2)

      result = Exhibit.future
      expect(result).to contain_exactly(exhibit_3)
    end
  end
end
