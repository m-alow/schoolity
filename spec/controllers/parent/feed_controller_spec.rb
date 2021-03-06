require 'rails_helper'

RSpec.describe Parent::FeedController, type: :controller do
  context 'guest' do
    describe 'GET #index' do
      it 'requires login' do
        get :index
        expect(response).to require_login
      end
    end
  end

  context 'authenticated user' do
    context 'non parent' do
      before { sign_in create(:user) }

      describe 'GET #index' do
        it 'requires parent' do
          get :index
          expect(response).to require_parent
        end
      end
    end

    context 'parent' do
      let(:parent) { create(:following).user }

      before { sign_in parent }

      describe 'GET #index' do
        it 'returns http success' do
          get :index
          expect(response).to have_http_status :success
        end
      end
    end
  end
end
