require 'rails_helper'

RSpec.describe BehaviorsController, type: :controller do
  let(:lesson) { create :lesson }
  let(:student) { create(:studying, classroom: lesson.day.classroom).student }
  let(:behavior) { Behavior.make(student: student, behaviorable: lesson).tap { |b| b.save! } }

  context 'guest' do
    describe 'GET #show' do
      it 'requires login' do
        get :show, id: behavior
        expect(response).to require_login
      end
    end
  end

  context 'authenticated user' do

    context 'non authorized' do
      before { sign_in create(:user) }

      describe 'GET #show' do
        it 'requires authorization' do
          get :show, id: behavior
          expect(response).to require_authorization
        end
      end
    end

    context 'authorized' do
      let(:user) { create(:following, student: student).user }

      before { sign_in user }

      describe 'GET #show' do
        it 'succeed' do
          get :show, id: behavior
          expect(response).to have_http_status :success
        end
      end
    end
  end
end
