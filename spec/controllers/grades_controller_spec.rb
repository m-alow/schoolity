require 'rails_helper'

RSpec.describe GradesController, type: :controller do
  let(:grade) { create :grade }

  context 'guest' do
    describe 'GET #show' do
      it 'requires login' do
        get :show, id: grade
        expect(response).to require_login
      end
    end
  end

  context 'authenticated user' do
    context 'non authorized' do
      before { sign_in create(:user) }

      describe 'GET #show' do
        it 'requires authorization' do
          get :show, id: grade
          expect(response).to require_authorization
        end
      end
    end

    context 'authorized' do
      let(:user) { create(:following, student: grade.student).user }
      before { sign_in user }

      describe 'GET #show' do
        it 'succeed' do
          get :show, id: grade
          expect(response).to have_http_status :success
        end
      end
    end
  end
end
