require 'rails_helper'

RSpec.describe Teacher::AgendasController, type: :controller do
  context 'guest' do
    describe 'GET #index' do
      it 'requires login' do
        get :index
        expect(response).to require_login
      end
    end

    describe 'GET #show' do
      it 'requires login' do
        get :show, date: '2010-10-5'
        expect(response).to require_login
      end
    end

    describe 'GET #edit' do
      it 'requires login' do
        get :edit, date: '2010-10-5'
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

      describe 'GET #show' do
        it 'requires teacher' do
          get :show, date: '2010-10-5'
          expect(response).to require_teacher
        end
      end

      describe 'GET #edit' do
        it 'requires teacher' do
          get :edit, date: '2010-10-5'
          expect(response).to require_teacher
        end
      end
    end

    context 'teacher' do
      let(:teacher) { create(:teaching).teacher }

      before { sign_in teacher }

      describe 'GET #index' do
        it 'succeed' do
          get :index
          expect(response).to have_http_status :success
        end
      end

      describe 'GET #show' do
        it 'succeed' do
          get :show, date: '2010-10-5'
          expect(response).to have_http_status :success
        end
      end

      describe 'GET #edit' do
        it 'succeed' do
          get :edit, date: '2010-10-5'
          expect(response).to have_http_status :success
        end
      end
    end
  end
end
