require 'rails_helper'

RSpec.describe Teacher::PanelController, type: :controller do
  context 'guest' do
    describe 'GET #index' do
      it 'requires login' do
        get :index
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
    end
  end
end
