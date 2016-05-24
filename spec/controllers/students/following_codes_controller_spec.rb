require 'rails_helper'
RSpec.describe Students::FollowingCodesController, type: :controller do
  let(:school) { create(:active_school) }
  let(:student) { create(:student, school: school) }
  let(:following_code) { FollowingCode.make!(student) }

  let(:non_authorized_user) { create(:user) }
  let(:authorized_user) { create(:school_administration, administrated_school: school).administrator }

  context 'guest' do
    describe 'GET #index' do
      it 'requires login' do
        get :index, student_id: student
        expect(response).to require_login
      end
    end

    describe 'GET #show' do
      it 'requires login' do
        get :show, id: following_code
        expect(response).to require_login
      end
    end

    describe 'POST #create' do
      it 'requires login' do
        post :create, student_id: student
        expect(response).to require_login
      end
    end

    describe 'DELETE #destroy' do
      it 'requires login' do
        delete :destroy, id: following_code
        expect(response).to require_login
      end
    end
  end

  context 'authenticated user' do
    context 'non authorized user' do
      before do
        sign_in non_authorized_user
      end

      describe 'GET #index' do
        it 'requires authorization' do
          get :index, student_id: student
          expect(response).to require_authorization
        end
      end

      describe 'GET #show' do
        it 'requires authorization' do
          get :show, id: following_code
          expect(response).to require_authorization
        end
      end

      describe 'POST #create' do
        it 'requires authorization' do
          post :create, student_id: student
          expect(response).to require_authorization
        end
      end

      describe 'DELETE #destroy' do
        it 'requires authorization' do
          delete :destroy, id: following_code
          expect(response).to require_authorization
        end
      end
    end

    context 'authorized user' do
      before do
        sign_in authorized_user
      end

      describe 'GET #index' do
        it 'returns http success' do
          get :index, student_id: student
          expect(response).to have_http_status :success
        end
      end

      describe 'GET #show' do
        it 'returns http success' do
          get :show, id: following_code
          expect(response).to have_http_status :success
        end
      end

      describe 'POST #create' do
        it 'creates a new following code' do
          expect {
            post :create, student_id: student
          }.to change(FollowingCode, :count)
        end

        it 'redirects to the new following code' do
          post :create, student_id: student
          expect(response).to redirect_to FollowingCode.last
        end
      end

      describe 'DELETE #create' do
        it 'destroys the requested following code' do
          delete :destroy, id: following_code
          expect(FollowingCode.exists?(following_code.id)).to be_falsy
        end

        it 'redirects to following codes index' do
          delete :destroy, id: following_code
          expect(response).to redirect_to student_following_codes_url(student)
        end
      end
    end
  end
end
