require 'rails_helper'

describe V2::HomepageController do
  describe '#index' do
    subject { get action_path }

    let(:article) { create(:article, :with_banner, :as_featured) }
    let(:artist) { create(:artist, :with_banner, :with_portrait, :as_featured) }
    let(:artwork) { create(:artwork, :with_image, :with_artist, :as_featured) }
    let(:exhibit) { create(:exhibit, :with_banner, :with_portrait, :as_featured) }
    let(:gallery) { create(:gallery, :with_banner, :as_featured) }
    let(:action_path) { v2_artists_path }

    it 'renders status and template' do
      subject
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
    end
  end
end
