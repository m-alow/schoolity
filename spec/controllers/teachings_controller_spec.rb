require 'rails_helper'

RSpec.describe TeachingsController, type: :controller do
  let(:school) { create(:active_school) }
  let(:school_class) { create(:school_class, school: school) }
  let(:classroom) { create(:classroom, school_class: school_class) }
  let(:teaching) { create(:teaching, classroom: classroom) }
  let(:a_subject) { create(:subject, school_class: school_class) }
  let(:teacher) { create(:user) }

  let(:authorized_user) { create(:school_administration, administrated_school: school).administrator }
  let(:non_authorized_user) { create(:user) }

  let(:valid_attributes) { attributes_for(:teaching, subject_id: a_subject, user_id: teacher.email) }
  let(:invalid_attributes) { attributes_for(:invalid_teaching, classroom_id: nil) }

  context 'guest user' do
    describe 'GET #index' do
      it 'requires login' do
        get :index, classroom_id: classroom
        expect(response).to require_login
      end
    end

    describe 'GET #show' do
      it 'requires login' do
        get :show, id: teaching
        expect(response).to require_login
      end
    end

    describe 'GET #new' do
      it 'requires login' do
        get :new, classroom_id: classroom
        expect(response).to require_login
      end
    end


    describe 'GET #edit' do
      it 'requires login' do
        get :edit, id: teaching
        expect(response).to require_login
      end
    end


    describe 'POST #create' do
      it 'requires login' do
        post :create, classroom_id: classroom, teaching: valid_attributes
        expect(response).to require_login
      end
    end


    describe 'PUT #update' do
      it 'requires login' do
        put :update, id: teaching, teaching: valid_attributes
        expect(response).to require_login
      end
    end


    describe 'DELETE #destroy' do
      it 'requires login' do
        delete :destroy, id: teaching
        expect(response).to require_login
      end
    end
  end

  context 'authenticated user' do
    context 'non authorized' do
      before do
        sign_in non_authorized_user
      end

      describe 'GET #index' do
        it 'requires authorization' do
          get :index, classroom_id: classroom
          expect(response).to require_authorization
        end
      end

      describe 'GET #show' do
        it 'requires authorization' do
          get :show, id: teaching
          expect(response).to require_authorization
        end
      end

      describe 'GET #new' do
        it 'requires authorization' do
          get :new, classroom_id: classroom
          expect(response).to require_authorization
        end
      end


      describe 'GET #edit' do
        it 'requires authorization' do
          get :edit, id: teaching
          expect(response).to require_authorization
        end
      end


      describe 'POST #create' do
        it 'requires authorization' do
          post :create, classroom_id: classroom, teaching: valid_attributes
          expect(response).to require_authorization
        end
      end


      describe 'PUT #update' do
        it 'requires authorization' do
          put :update, id: teaching, teaching: valid_attributes
          expect(response).to require_authorization
        end
      end


      describe 'DELETE #destroy' do
        it 'requires authorization' do
          delete :destroy, id: teaching
          expect(response).to require_authorization
        end
      end
    end

    context 'authorized' do
      before do
        sign_in authorized_user
      end

      describe 'GET #index' do
        it 'succeed' do
          get :index, classroom_id: classroom
          expect(response).to have_http_status :success
        end
      end

      describe 'GET #show' do
        it 'succeed' do
          get :show, id: teaching
          expect(response).to have_http_status :success
        end
      end

      describe 'GET #new' do
        it 'succeed' do
          get :new, classroom_id: classroom
          expect(response).to have_http_status :success
        end
      end

      describe 'GET #edit' do
        it 'succeed' do
          get :edit, id: teaching, teaching: valid_attributes
          expect(response).to have_http_status :success
        end
      end

      describe 'POST #create' do
        context 'with valid params' do
          it 'creates a new Teaching' do
            expect do
              post :create, classroom_id: classroom, teaching: valid_attributes
            end.to change(Teaching, :count).by(1)
          end

          it 'redirects to the created teaching' do
            post :create, classroom_id: classroom, teaching: valid_attributes
            expect(response).to redirect_to(Teaching.last)
          end
        end

        context 'with invalid params' do
          it 'does not create a new teaching' do
            expect {
              post :create, classroom_id: classroom, teaching: invalid_attributes
            }.not_to change(Teaching, :count)
          end

          it "re-renders the 'new' template" do
            post :create, classroom_id: classroom, teaching: invalid_attributes
            expect(response).to render_template('new')
          end
        end
      end

      describe 'PUT #update' do
        context 'with valid params' do
          let(:new_attributes) { attributes_for(:teaching) }

          it 'updates the requested teaching' do
            expect {
              put :update, id: teaching, teaching: new_attributes
              teaching.reload
            }.to change(teaching, :updated_at)
          end

          it 'redirects to the teaching' do
            put :update, id: teaching, teaching: valid_attributes
            expect(response).to redirect_to(teaching)
          end
        end

        context 'with invalid params' do
          it 'does not update the teaching' do
            expect {
              put :update, id: teaching, teaching: invalid_attributes
            }.not_to change(teaching, :updated_at)
          end

          it "re-renders the 'edit' template" do
            put :update, id: teaching, teaching: invalid_attributes
            expect(response).to render_template('edit')
          end
        end
      end

      # describe 'DELETE #destroy' do
      #   it 'destroys the requested teaching' do
      #     teaching = Teaching.create! valid_attributes
      #     expect do
      #       delete :destroy, { id: teaching.to_param }, valid_session
      #     end.to change(Teaching, :count).by(-1)
      #   end

      #   it 'redirects to the teachings list' do
      #     teaching = Teaching.create! valid_attributes
      #     delete :destroy, { id: teaching.to_param }, valid_session
      #     expect(response).to redirect_to(teachings_url)
      #   end
      # end
    end
  end
end
