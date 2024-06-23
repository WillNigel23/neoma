require 'rails_helper'

describe V2::Admin::HomepageController do
  include_context 'user_types'

  describe '#index' do
    subject { get action_path }

    let(:article) { create(:article, :with_banner, :as_featured) }
    let(:artist) { create(:artist, :with_banner, :with_portrait, :as_featured) }
    let(:artwork) { create(:artwork, :with_image, :with_artist, :as_featured) }
    let(:exhibit) { create(:exhibit, :with_banner, :with_poster, :as_featured) }
    let(:gallery) { create(:gallery, :with_banner, :as_featured) }
    let(:action_path) { v2_admin_root_path }

    it 'renders redirects to login' do
      subject
      expect(response).to redirect_to(new_v2_admin_user_session_path)
    end

    it 'renders redirects to root_path' do
      login_as(customer)

      subject
      expect(response).to redirect_to(v2_root_path)
    end

    it 'renders status and template' do
      login_as(admin)

      subject
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
    end
  end

  describe '#set_featured_items' do
    subject { post action_path }

    let!(:exhibit_1) { create(:exhibit, :with_banner, :with_poster, :as_featured, status: :live) }
    let!(:exhibit_2) { create(:exhibit, :with_banner, :with_poster, status: :live) }
    let!(:exhibits) { FeaturedItem.exhibits.order(position: :asc) }
    let(:action_path) { set_featured_items_v2_admin_homepage_index_path }

    it 'renders redirects to login' do
      subject
      expect(response).to redirect_to(new_v2_admin_user_session_path)
    end

    it 'renders redirects to root_path' do
      login_as(customer)

      subject
      expect(response).to redirect_to(v2_root_path)
    end

    context 'edits featured items' do
      before { login_as(admin) }

      it 'adds featured item' do
        expect do
          post action_path, params: {
            featured_item: {
              featureable_id: [exhibit_1.id, exhibit_2.id],
              _destroy: ['false', 'false']
            },
            featureable_type: 'Exhibit'
          }
        end.to change { exhibits.reload.count }
      end

      it 'deletes featured item' do
        expect do
          post action_path, params: {
            featured_item: {
              featureable_id: [exhibit_1.id],
              _destroy: [exhibit_1.id]
            },
            featureable_type: 'Exhibit'
          }
        end.to change { exhibits.reload.count }
      end

      it 'edits featured item' do
        expect(exhibits.reload.first.featureable).to eq(exhibit_1)
        expect do
          post action_path, params: {
            featured_item: {
              featureable_id: [exhibit_2.id],
              _destroy: ['false']
            },
            featureable_type: 'Exhibit'
          }
        end.not_to change { exhibits.reload.count }
        expect(exhibits.reload.first.featureable).to eq(exhibit_2)
      end

      it 'changes order of featured item' do
        expect do
          post action_path, params: {
            featured_item: {
              featureable_id: [exhibit_2.id, exhibit_1.id],
              _destroy: ['false', 'false']
            },
            featureable_type: 'Exhibit'
          }
        end.to change { exhibits.reload.count }
        expect(exhibits.first.featureable).to eq(exhibit_2)
      end
    end
  end
end
