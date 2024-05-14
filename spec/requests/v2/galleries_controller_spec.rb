require 'rails_helper'

describe V2::GalleriesController do
  describe '#index' do
    subject { get action_path }

    let(:gallery) { create(:gallery, :with_banner) }
    let(:action_path) { v2_galleries_path }

    it 'renders status and template' do
      subject
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
    end
  end

  describe '#show' do
    subject { get action_path }

    let(:gallery) { create(:gallery, :with_banner) }
    let(:action_path) { v2_gallery_path(gallery) }

    it 'renders status and template' do
      subject
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:show)
    end
  end
end
