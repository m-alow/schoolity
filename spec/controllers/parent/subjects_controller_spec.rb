require 'rails_helper'

RSpec.describe Parent::SubjectsController, type: :controller do
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
        it 'succeed if student is enrolled in a classroom' do
          create(:studying, student: following.student)
          get :index, following_id: following
          expect(flash.now[:alert]).to be_nil
          expect(response).to have_http_status :success
        end

        it 'show a warning if student is not enrolled in classroom' do
          get :index, following_id: following
          expect(flash.now[:alert]).to eq 'No Classroom'
          expect(response).to have_http_status :success
        end
      end
    end
  end
end
