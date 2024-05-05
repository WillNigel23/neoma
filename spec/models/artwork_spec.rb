# frozen_string_literal: true

# == Schema Information
#
# Table name: artworks
#
#  id          :bigint           not null, primary key
#  description :text
#  medium      :string
#  price       :integer
#  size        :string
#  slug        :string
#  status      :integer          default("draft"), not null
#  title       :string           not null
#  year        :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  artist_id   :bigint
#
# Indexes
#
#  index_artworks_on_artist_id  (artist_id)
#  unique_slug_per_artwork      (title) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (artist_id => artists.id)
#
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
        expect(artwork.image.attached?).to be true
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
