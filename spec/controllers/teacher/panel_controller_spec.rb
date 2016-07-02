require 'rails_helper'

RSpec.describe Teacher::PanelController, type: :controller do
  context 'guest' do
    describe 'GET #index' do
      it 'requires login' do
        get :index
        expect(response).to require_login
      end
    end

    describe 'GET #exams' do
      it 'requires login' do
        get :exams
        expect(response).to require_login
      end
    end

    describe 'GET #announcements' do
      it 'requires login' do
        get :announcements
        expect(response).to require_login
      end
    end
  end

  context 'authenticated user' do
    context 'not a teacher' do
      before { sign_in create(:user) }

      describe 'GET #index' do
        it 'requires a teacher' do
          get :index
          expect(response).to require_teacher
        end
      end

      describe 'GET #exams' do
        it 'requires a teacher' do
          get :exams
          expect(response).to require_teacher
        end
      end

      describe 'GET #announcements' do
        it 'requires a teacher' do
          get :announcements
          expect(response).to require_teacher
        end
      end
    end

    context 'teacher' do
      let(:user) { create(:teaching).teacher }

      before { sign_in user }

      describe 'GET #index' do
        it 'renders :index' do
          get :index
          expect(response).to render_template 'index'
        end
      end

      describe 'GET #exams' do
        it 'renders :exams' do
          get :exams
          expect(response).to render_template 'exams'
        end
      end

      describe 'GET #announcements' do
        it 'renders :announcements' do
          get :announcements
          expect(response).to render_template 'announcements'
        end
      end
    end
  end
end
