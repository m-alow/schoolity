require 'rails_helper'

RSpec.describe Admin::PanelController, type: :controller do
  context 'guest' do
    describe 'GET #index' do
      it 'requires login' do
        get :index
        expect(response).to require_login
      end
    end
  end

  context 'authenticated user' do
    context 'non admin' do
      before { sign_in create(:user) }

      describe 'GET #index' do
        it 'requires a admin' do
          get :index
          expect(response).to require_admin
        end
      end
    end

    context 'admin' do
      let(:admin) { create(:school_administration).administrator }

      before { sign_in admin }

      describe 'GET #index' do
        it 'returns http success' do
          get :index
          expect(response).to have_http_status :success
        end
      end
    end
  end
end
