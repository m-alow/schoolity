require 'rails_helper'

RSpec.describe Classrooms::FollowingCodesController, type: :controller do
  let(:school) { create(:school) }
  let(:school_class) { create(:school_class, school: school) }
  let(:classroom) { create(:classroom, school_class: school_class) }

  let(:non_authorized_user) { create(:user) }
  let(:authorized_user) { create(:school_administration, administrated_school: school).administrator }

  context 'guest' do
    describe 'GET #index' do
      it 'requires login' do
        get :index, classroom_id: classroom
        expect(response).to require_login
      end
    end

    describe 'POST #create' do
      it 'requires login' do
        post :create, classroom_id: classroom
        expect(response).to require_login
      end
    end
  end

  context 'authenticated user' do
    before do
      classroom.studyings << build(:studying, student: create(:student, school: school))
      classroom.studyings << build(:studying, student: create(:student, school: school))
    end

    context 'non authorized user' do
      before { sign_in non_authorized_user }

      describe 'GET #index' do
        it 'requires authorization' do
          get :index, classroom_id: classroom
          expect(response).to require_authorization
        end
      end

      describe 'POST #create' do
        it 'requires authorization' do
          post :create, classroom_id: classroom
          expect(response).to require_authorization
        end
      end
    end

    context 'authorized user' do
      before { sign_in authorized_user }

      describe 'GET #index' do
        it 'returns http success' do
          get :index, classroom_id: classroom
          expect(response).to have_http_status :success
        end
      end

      describe 'POST #create' do
        it 'creates new following codes' do
          expect {
            post :create, classroom_id: classroom
          }.to change(FollowingCode, :count).by 2
        end

        it 'redirect to classroom following codes page' do
          post :create, classroom_id: classroom
          expect(response).to redirect_to classroom_following_codes_url(classroom)
        end
      end
    end
  end
end
