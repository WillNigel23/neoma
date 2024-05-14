require 'rails_helper'

describe Article do
  let(:article) { create(:article) }

  describe 'fields' do
    describe 'slug' do
      it 'converts title to slug' do
        expect(article.title.parameterize).to eq(article.slug)
      end

      it 'finds by slug' do
        expect(article).to eq(described_class.friendly.find(article.slug))
      end
    end

    describe 'images' do
      let(:article) { create(:article, :with_banner) }

      it 'has attached banner' do
        expect(article.banner).not_to be_nil
      end
    end

    describe 'content_sections' do
      let(:article) { create(:article, :with_content_sections) }

      it 'has content sections' do
        expect(article.content_sections.count).to eq(1)
      end
    end
  end

  describe 'validations' do
    describe 'title' do
      it 'requires title' do
        article.title = nil
        expect(article).not_to be_valid
      end

      it 'requires unique title' do
        article2 = build(:article, title: article.title)
        expect(article2).not_to be_valid
      end

      it 'requires date' do
        article.date = nil
        expect(article).not_to be_valid
      end
    end
  end
end
