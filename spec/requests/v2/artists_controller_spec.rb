require 'rails_helper'

describe V2::ArtistsController do
  describe '#index' do
    subject { get action_path }

    let(:artist) { create(:artist, :with_banner, :with_portrait) }
    let(:action_path) { v2_artists_path }

    it 'renders status and template' do
      subject
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
    end
  end

  describe '#show' do
    subject { get action_path }

    let(:artist) { create(:artist, :with_banner, :with_portrait) }
    let(:action_path) { v2_artist_path(artist) }

    it 'renders status and template' do
      subject
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:show)
    end
  end
end
