require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  let(:message) { create :message }

  context 'guest' do
    describe 'GET #show' do
      it 'requires login' do
        get :show, id: message
        expect(response).to require_login
      end
    end
  end

  context 'authenticated user' do
    context 'non authorized' do
      before { sign_in create(:user ) }

      describe 'GET #show' do
        it 'requires authorization ' do
          get :show, id: message
          expect(response).to require_authorization
        end
      end
    end

    context 'authorized' do
      let(:parent) { create(:following, user: message.user, student: message.student).user }
      before { sign_in parent }

      describe 'GET #show' do
        it 'succeed ' do
          get :show, id: message
          expect(response).to have_http_status :success
        end
      end
    end
  end
end
