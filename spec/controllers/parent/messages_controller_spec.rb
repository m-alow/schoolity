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

    describe 'POST #create' do
      it 'requires login' do
        post :create, following_id: following
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

      describe 'POST #create' do
        it 'requires authorization' do
          post :create, following_id: following
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

      describe 'POST #create' do
        let(:valid_attributes) { attributes_for :message }

        it 'creates a new message' do
          expect {
            post :create, following_id: following, message: valid_attributes
          }.to change(Message, :count).by(1)
        end

        it 'sets the signed in users as the messages author' do
          post :create, following_id: following, message: valid_attributes
          expect(Message.last.user).to eq parent
        end

        it 'sets the student related to the following as the message student' do
          post :create, following_id: following, message: valid_attributes
          expect(Message.last.student).to eq following.student
        end

        it 'redirects to the message' do
          post :create, following_id: following, message: valid_attributes
          expect(response).to redirect_to Message.last
        end
      end
    end
  end
end
