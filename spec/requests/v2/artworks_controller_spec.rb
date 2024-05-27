require 'rails_helper'

describe V2::ArtworksController do
  describe '#index' do
    subject { get action_path }

    let(:artwork) { create(:artwork, :with_image) }
    let(:action_path) { v2_artworks_path }

    it 'renders status and template' do
      subject
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
    end

    context 'when sorting applied' do
      it 'renders status and template' do
        get action_path, as: :turbo_stream,
          params: { sort_by: 'price_asc' }

        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:index)
      end
    end
  end

  describe '#show' do
    subject { get action_path }

    let(:artwork) { create(:artwork, :with_image) }
    let(:action_path) { v2_artwork_path(artwork) }

    it 'renders status and template' do
      subject
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:show)
    end
  end
end
