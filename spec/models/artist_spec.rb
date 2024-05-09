# == Schema Information
#
# Table name: artists
#
#  id          :bigint           not null, primary key
#  description :string
#  full_name   :string
#  name        :string           not null
#  role        :string
#  slug        :string
#  status      :integer          default("draft"), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  unique_slug_per_artist  (name) UNIQUE
#
require 'rails_helper'

describe Artist do
  let(:artist) { create(:artist) }

  describe 'fields' do
    describe 'slug' do
      it 'converts title to slug' do
        expect(artist.name.parameterize).to eq(artist.slug)
      end

      it 'finds by slug' do
        expect(artist).to eq(described_class.friendly.find(artist.slug))
      end
    end

    describe 'images' do
      let(:artist) { create(:artist, :with_images) }

      it 'has attached banner' do
        expect(artist.banner.attached?).to be true
      end

      it 'has attached portrait' do
        expect(artist.portrait.attached?).to be true
      end
    end

    describe 'artworks' do
      let(:artist) { create(:artist, :with_artworks) }

      it 'has artworks' do
        expect(artist.artworks.count).to eq(1)
      end
    end

    describe 'exhibits' do
      let!(:artwork) { create(:artwork, artist:) }
      let!(:exhibit) { create(:exhibit, artworks: [artwork]) }

      it 'has exhibits' do
        expect(artist.exhibits.count).to eq(1)
      end
    end

    describe 'content_sections' do
      let(:artist) { create(:artist, :with_content_sections) }

      it 'has content sections' do
        expect(artist.content_sections.count).to eq(1)
      end
    end
  end

  describe 'validations' do
    describe 'name' do
      it 'requires name' do
        artist.name = nil
        expect(artist).not_to be_valid
      end

      it 'requires unique title' do
        artist2 = build(:artist, name: artist.name)
        expect(artist2).not_to be_valid
      end
    end
  end
end
