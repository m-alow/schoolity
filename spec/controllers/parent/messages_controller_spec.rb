require 'rails_helper'

RSpec.describe Parent::MessagesController, type: :controller do
  let(:following) { create :following }

  context 'guest' do
    describe 'GET #new' do
      it 'requires login' do
        get :new, following_id: following
        expect(response).to require_login
      end
    end
  end

  context 'authenticated user' do
    context 'non authorized' do
      before { sign_in create(:user ) }

      describe 'GET #new' do
        it 'requires authorization ' do
          get :new, following_id: following
          expect(response).to require_authorization
        end
      end
    end

    context 'authorized' do
      let(:parent) { following.user }
      before { sign_in parent }

      describe 'GET #new' do
        it 'succeed ' do
          get :new, following_id: following
          expect(response).to have_http_status :success
        end
      end
    end
  end
end
