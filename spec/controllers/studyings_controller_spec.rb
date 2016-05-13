require 'rails_helper'

RSpec.describe StudyingsController, type: :controller do
  let(:valid_attributes) { attributes_for(:studying, classroom_id: classroom.id) }
  let(:invalid_attributes) { attributes_for(:invalid_studying, beginning_date: nil) }

  let(:school) { create(:active_school) }
  let(:school_class) { create(:school_class, school: school) }
  let(:classroom) { create(:classroom, school_class: school_class) }
  let(:student) { create(:student, school: school) }
  let(:studying) { create(:studying, student: student, classroom: classroom) }
  let(:non_authorized_user) { create(:user) }
  let(:authorized_user) { create(:school_administration, administrated_school: school).administrator }

  context 'guest' do
    describe 'GET #index' do
      it 'requires log in' do
        get :index, student_id: student
        expect(response).to require_login
      end
    end

    describe 'GET #show' do
      it 'requires log in' do
        get :show, id: studying
        expect(response).to require_login
      end
    end

    describe 'GET #new' do
      it 'requires log in' do
        get :new, student_id: student
        expect(response).to require_login
      end
    end

    describe 'GET #edit' do
      it 'requires log in' do
        get :edit, id: studying
        expect(response).to require_login
      end
    end

    describe 'POST #create' do
      it 'requires log in' do
        post :create, student_id: student, studying: valid_attributes
        expect(response).to require_login
      end
    end

    describe 'PUT #update' do
      it 'requires log in' do
        put :update, id: studying, studying: valid_attributes
        expect(response).to require_login
      end
    end

    describe 'DELETE #destroy' do
      it 'requires log in' do
        delete :destroy, id: studying
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
        it 'requires autorization' do
          get :index, student_id: student
          expect(response).to require_authorization
        end
      end

      describe 'GET #show' do
        it 'requires autorization' do
          get :show, id: studying
          expect(response).to require_authorization
        end
      end

      describe 'GET #new' do
        it 'requires autorization' do
          get :new, student_id: student
          expect(response).to require_authorization
        end
      end

      describe 'GET #edit' do
        it 'requires autorization' do
          get :edit, id: studying
          expect(response).to require_authorization
        end
      end

      describe 'POST #create' do
        it 'requires autorization' do
          post :create, student_id: student, studying: valid_attributes
          expect(response).to require_authorization
        end
      end

      describe 'PUT #update' do
        it 'requires autorization' do
          put :update, id: studying, studying: valid_attributes
          expect(response).to require_authorization
        end
      end

      describe 'DELETE #destroy' do
        it 'requires autorization' do
          delete :destroy, id: studying
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
          get :index, student_id: student
          expect(response).to have_http_status :success
        end
      end

      describe 'GET #show' do
        it 'succeed' do
          get :show, id: studying
          expect(response).to have_http_status :success
        end
      end

      describe 'GET #new' do
        it 'succeed' do
          get :new, student_id: student
          expect(assigns(:studying)).to be_a_new(Studying)
        end
      end

      describe 'GET #edit' do
        it 'succeed' do
          get :edit, id: studying
          expect(response).to have_http_status :success
        end
      end

      describe 'POST #create' do
        context 'with valid params' do
          it 'creates a new Studying' do
            expect {
              post :create, student_id: student, studying: valid_attributes
            }.to change(Studying, :count).by(1)
          end

          it 'redirects to the created studying' do
            post :create, student_id: student, studying: valid_attributes
            expect(response).to redirect_to(Studying.last)
          end
        end

        context 'with invalid params' do
          it 'does not create a new studying' do
            expect {
              post :create, student_id: student, studying: invalid_attributes
            }.not_to change(Studying, :count)
          end

          it "re-renders the 'new' template" do
            post :create, student_id: student, studying: { beginning_date: nil }
            expect(response).to render_template :new
          end
        end
      end

      describe 'PUT #update' do
        context 'with valid params' do
          let(:new_attributes) { { beginning_date: Date.new(2015, 12, 12) } }

          it 'updates the requested studying' do
            put :update, id: studying, studying: new_attributes
            studying.reload
            expect(studying.beginning_date).to eq Date.new(2015, 12, 12)
          end

          it 'redirects to the studying' do
            put :update, id: studying, studying: valid_attributes
            expect(response).to redirect_to(studying)
          end
        end

        context 'with invalid params' do
          it 'does not change the studying' do
            put :update, id: studying, studying: invalid_attributes
            studying.reload
            expect(studying.beginning_date).not_to be_nil
          end

          it "re-renders the 'edit' template" do
            put :update, id: studying, studying: invalid_attributes
            expect(response).to render_template('edit')
          end
        end
      end

      describe 'DELETE #destroy' do
        it 'destroys the requested studying' do
          delete :destroy, id: studying
          expect(Studying.exists?(studying.id)).to be_falsy
        end

        it 'redirects to the studyings list' do
          delete :destroy, id: studying
          expect(response).to redirect_to(student_studyings_url(student))
        end
      end
    end
  end
end
