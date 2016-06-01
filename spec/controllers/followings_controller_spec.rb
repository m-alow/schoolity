require 'rails_helper'

RSpec.describe FollowingsController, type: :controller do
  let(:student) { create(:student) }
  let(:following_code) { FollowingCode.make! student }
  let(:following) { create(:following, student: student, user: authorized_user) }

  let(:non_authorized_user) { create(:user) }
  let(:authorized_user) { create(:user) }

  let(:valid_attributes) { {following: attributes_for(:following), following_code: following_code.code, student_full_name: student.full_name} }
  let(:invalid_attributes) { valid_attributes.merge(following_code: '') }

  context 'guest' do
    describe 'GET #index' do
      it 'requires login' do
        get :index
        expect(response).to require_login
      end
    end

    describe 'GET #show' do
      it 'requires login' do
        get :show, id: following
        expect(response).to require_login
      end
    end

    describe 'GET #new' do
      it 'requires login' do
        get :new
        expect(response).to require_login
      end
    end

    describe 'POST #create' do
      it 'requires login' do
        post :create, **valid_attributes
        expect(response).to require_login
      end
    end

    describe 'DELETE #destroy' do
      it 'requires login' do
        delete :destroy, id: following
        expect(response).to require_login
      end
    end
  end

  context 'authenticated user' do
    shared_examples_for 'public access' do

      describe 'GET #index' do
        it 'succeed' do
          get :index
          expect(response).to have_http_status :success
        end
      end

      describe 'GET #new' do
        it 'succeed' do
          get :new
          expect(response).to have_http_status :success
        end
      end

      describe 'POST #create' do
        context 'with valid params' do
          it 'creates a new following' do
            expect {
              post :create, **valid_attributes
            }.to change(Following, :count).by(1)
          end

          it 'redirects to the created following' do
            post :create, **valid_attributes
            expect(response).to redirect_to Following.last
          end
        end

        context 'with invalid params' do
          it 'does not create a new following' do
            expect {
              post :create, **invalid_attributes
            }.not_to change(Following, :count)
          end

          it "re-render the 'new' template" do
            post :create, **invalid_attributes
            expect(response).to render_template :new
          end
        end
      end
    end

    context 'non authorized' do
      before { sign_in non_authorized_user }

      it_behaves_like 'public access'

      describe 'GET #show' do
        it 'requires authorization' do
          get :show, id: following
          expect(response).to require_authorization
        end
      end

      describe 'DELETE #destroy' do
        it 'requires authorization' do
          delete :destroy, id: following
          expect(response).to require_authorization
        end
      end
    end

    context 'authorized user' do
      before { sign_in authorized_user }

      it_behaves_like 'public access'

      describe 'GET #show' do
        it 'succeed' do
          get :show, id: following
          expect(response).to have_http_status :success
        end
      end

      describe 'DELETE #destroy' do
        it 'destroys the requested following' do
          delete :destroy, id: following
          expect(Following.exists?(following.id)).to be_falsy
        end

        it 'redirects to the followings list' do
          delete :destroy, id: following
          expect(response).to redirect_to(followings_url)
        end

      end
    end
  end
end
