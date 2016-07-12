require 'rails_helper'

RSpec.describe Teacher::NotificationsController, type: :controller do
  context 'guest' do
    describe 'GET #index' do
      it 'requires login' do
        get :index
        expect(response).to require_login
      end
    end

    describe 'GET #all' do
      it 'requires login' do
        get :all
        expect(response).to require_login
      end
    end
  end

  context 'authenticated user' do
    context 'non teacher' do
      before { sign_in create(:user) }

      describe 'GET #index' do
        it 'requires teacher' do
          get :index
          expect(response).to require_teacher
        end
      end

      describe 'GET #all' do
        it 'requires teacher' do
          get :all
          expect(response).to require_teacher
        end
      end
    end

    context 'teacher' do
      let(:teacher) { create(:following).user }

      before { sign_in teacher }

      describe 'GET #index' do
        it 'returns http success' do
          get :index
          expect(response).to have_http_status :success
        end
      end

      describe 'GET #all' do
        it 'returns http success' do
          get :all
          expect(response).to have_http_status :success
        end
      end
    end
  end
end
