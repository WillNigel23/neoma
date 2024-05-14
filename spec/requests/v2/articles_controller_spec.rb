require 'rails_helper'

describe V2::ArticlesController do
  describe '#index' do
    subject { get action_path }

    let(:article) { create(:article, :with_banner) }
    let(:action_path) { v2_articles_path }

    it 'renders status and template' do
      subject
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
    end
  end

  describe '#show' do
    subject { get action_path }

    let(:article) { create(:article, :with_banner) }
    let(:action_path) { v2_article_path(article) }

    it 'renders status and template' do
      subject
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:show)
    end
  end
end
