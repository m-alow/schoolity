require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  let(:valid_attributes) { attributes_for :student }
  let(:invalid_attributes) { attributes_for :invalid_student }

  let(:school) { create(:active_school) }
  let(:student) { create(:student, school: school) }
  let(:authorized_user) { create(:school_administration, administrated_school: school).administrator }
  let(:non_authorized_user) { create(:user) }
  context 'guest' do
    describe 'GET #index' do
      it 'requires login' do
        get :index, school_id: school
        expect(response).to require_login
      end
    end

    describe 'GET #show' do
      it 'requires login' do
        get :show, id: student
        expect(response).to require_login
      end
    end

    describe 'GET #new' do
      it 'requires login' do
        get :new, school_id: school
        expect(response).to require_login
      end
    end

    describe 'GET #edit' do
      it 'requires login' do
        get :edit, id: student
        expect(response).to require_login
      end
    end

    describe 'POST #create' do
      it 'requires login' do
        post :create, school_id: school, student: valid_attributes
        expect(response).to require_login
      end
    end

    describe 'PUT #update' do
      it 'requires login' do
        put :update, id: student, student: valid_attributes
        expect(response).to require_login
      end
    end

    describe 'DELETE #destroy' do
      it 'requires login' do
        delete :destroy, id: student
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
          get :index, school_id: school
          expect(response).to require_authorization
        end
      end

      describe 'GET #show' do
        it 'requires authorization' do
          get :show, id: student
          expect(response).to require_authorization
        end
      end

      describe 'GET #new' do
        it 'requires authorization' do
          get :new, school_id: school
          expect(response).to require_authorization
        end
      end

      describe 'GET #edit' do
        it 'requires authorization' do
          get :edit, id: student
          expect(response).to require_authorization
        end
      end

      describe 'POST #create' do
        it 'requires authorization' do
          post :create, school_id: school, student: valid_attributes
          expect(response).to require_authorization
        end
      end

      describe 'PUT #update' do
        it 'requires authorization' do
          put :update, id: student, student: valid_attributes
          expect(response).to require_authorization
        end
      end

      describe 'DELETE #destroy' do
        it 'requires authorization' do
          delete :destroy, id: student
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
          get :index, school_id: school
          expect(response.status).to be 200
        end
      end

      describe 'GET #show' do
        it 'succeed' do
          get :show, id: student
          expect(response.status).to be 200
        end
      end

      describe 'GET #new' do
        it 'succeed' do
          get :new, school_id: school
          expect(response.status).to be 200
        end
      end

      describe 'GET #edit' do
        it 'succeed' do
          get :edit, id: student
          expect(response.status).to be 200
        end
      end

      describe 'POST #create' do
        context 'with valid params' do
          it 'creates a new Student' do
            expect {
              post :create, school_id: school, student: valid_attributes
            }.to change(Student, :count).by(1)
          end

          it 'redirects to the created student' do
            post :create, school_id: school, student: valid_attributes
            expect(response).to redirect_to(Student.last)
          end
        end

        context 'with invalid params' do
          it 'does not create a new student' do
            expect {
              post :create, school_id: school, student: invalid_attributes
            }.not_to change(Student, :count)
          end

          it "re-renders the 'new' template" do
            post :create, school_id: school, student: invalid_attributes
            expect(response).to render_template('new')
          end
        end
      end

      describe 'PUT #update' do
        context 'with valid params' do
          let(:new_attributes) { attributes_for(:student, first_name: 'Mohammad') }

          it 'updates the requested student' do
            put :update, id: student, student: new_attributes
            student.reload
            expect(student.first_name).to eq 'Mohammad'
          end

          it 'redirects to the student' do
            put :update, id: student, student: valid_attributes
            expect(response).to redirect_to(student)
          end
        end

        context 'with invalid params' do
          it 'does not change the student' do
            put :update, id: student, student: attributes_for(:invalid_student, first_name: 'Mohammad', last_name: '')
            student.reload
            expect(student.first_name).not_to eq 'Mohammad'
            expect(student.last_name).not_to eq ''
          end

          it "re-renders the 'edit' template" do
            put :update, id: student, student: invalid_attributes
            expect(response).to render_template('edit')
          end
        end
      end

      describe 'DELETE #destroy' do
        it 'destroys the requested student' do
          delete :destroy, id: student
          expect(Student.exists?(student.id)).to be_falsy
        end

        it 'redirects to the students list' do
          delete :destroy, id: student
          expect(response).to redirect_to(school_students_url(school))
        end
      end
    end
  end
end
