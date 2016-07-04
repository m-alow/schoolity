require 'rails_helper'

RSpec.describe Parent::AgendasController, type: :controller do
  let(:following) { create :following }

  context 'guest' do
    describe 'GET #index' do
      it 'require login' do
        get :index, following_id: following
        expect(response).to require_login
      end
    end

    describe 'GET #show' do
      it 'require login' do
        get :show, following_id: following, date: '2010-10-10'
        expect(response).to require_login
      end
    end
  end

  context 'authenticated user' do
    context 'non authorized' do
      before { sign_in create(:user) }

      describe 'GET #index' do
        it 'require authorization' do
          get :index, following_id: following
          expect(response).to require_authorization
        end
      end

      describe 'GET #show' do
        it 'require authorization' do
          get :show, following_id: following, date: '2010-10-10'
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

      describe 'GET #show' do
        it 'succeed' do
          get :show, following_id: following, date: '2010-10-10'
          expect(response).to have_http_status :success
        end
      end
    end
  end
end
