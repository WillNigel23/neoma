# frozen_string_literal: true

require 'rails_helper'

describe V2::ExhibitsController do
  describe '#index' do
    subject { get action_path }

    let(:exhibit) { create(:exhibit, :with_images, :with_end_date) }
    let(:action_path) { v2_exhibits_path }

    it 'renders status and template' do
      subject
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
    end
  end

  describe '#show' do
    subject { get action_path }

    let(:exhibit) { create(:exhibit, :with_images, :with_end_date) }
    let(:action_path) { v2_exhibit_path(exhibit) }

    it 'renders status and template' do
      subject
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:show)
    end
  end
end
