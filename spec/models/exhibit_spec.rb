# frozen_string_literal: true

# == Schema Information
#
# Table name: exhibits
#
#  id         :bigint           not null, primary key
#  end_date   :date
#  slug       :string
#  start_date :date             not null
#  status     :integer          default("draft"), not null
#  subtitle   :string
#  summary    :text
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  unique_slug_per_exhibit  (title) UNIQUE
#
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
      let(:exhibit) { create(:exhibit, :with_images) }

      it 'has attached banner' do
        expect(exhibit.banner.attached?).to be true
      end

      it 'has attached poster' do
        expect(exhibit.poster.attached?).to be true
      end
    end

    describe 'artists' do
      let(:exhibit) { create(:exhibit, :with_artists) }

      it 'has artists' do
        expect(exhibit.artists.count).to eq(1)
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
end
