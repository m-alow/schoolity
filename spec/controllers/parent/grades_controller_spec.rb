require 'rails_helper'

RSpec.describe Parent::GradesController, type: :controller do
  let(:following) { create :following }

  context 'guest' do
    describe 'GET #index' do
      it 'requires login' do
        get :index, following_id: following
        expect(response).to require_login
      end
    end
  end

  context 'authenticates user' do
    context 'non authorized' do
      before { sign_in create(:user) }

      describe 'GET #index' do
        it 'requires authorization' do
          get :index, following_id: following
          expect(response).to require_authorization
        end
      end
    end

    context 'authorized' do
      let(:parent) { following.user }
      before { sign_in parent }

      describe 'GET #index' do
        it 'succeed' do
          get :index, following_id: following
          expect(response).to have_http_status :success
        end
      end
    end
  end
end
