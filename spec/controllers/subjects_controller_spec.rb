require 'rails_helper'

RSpec.describe SubjectsController, type: :controller do
  let(:school) { create(:active_school) }
  let(:school_class) { create(:school_class, school: school) }
  let(:a_subject) { create(:subject, school_class: school_class) }

  let(:authorized_user) { create(:school_administration, administrated_school: school).administrator }
  let(:non_authorized_user) { create(:user) }

  let(:valid_attributes) { attributes_for(:subject) }
  let(:invalid_attributes) { attributes_for(:invalid_subject) }

  context 'guest user' do
    describe 'GET #index' do
      it 'requires log in' do
        get :index, school_class_id: school_class
        expect(response).to require_login
      end
    end

    describe 'GET #show' do
      it 'requires log in' do
        get :show, id: a_subject
        expect(response).to require_login
      end
    end

    describe 'GET #new' do
      it 'requires log in' do
        get :new, school_class_id: school_class
        expect(response).to require_login
      end
    end
    describe 'GET #edit' do
      it 'requires log in' do
        get :edit, id: a_subject
        expect(response).to require_login
      end
    end

    describe 'POST #create' do
      it 'requires log in' do
        post :create, school_class_id: school_class, subject: valid_attributes
        expect(response).to require_login
      end
    end

    describe 'PUT #update' do
      it 'requires log in' do
        put :update, id: a_subject, subject: valid_attributes
        expect(response).to require_login
      end
    end

    describe 'DELETE #destroy' do
      it 'requires log in' do
        delete :destroy, id: a_subject
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
          get :index, school_class_id: school_class
          expect(response).to require_authorization
        end
      end

      describe 'GET #show' do
        it 'requires authorization' do
          get :show, id: a_subject
          expect(response).to require_authorization
        end
      end

      describe 'GET #new' do
        it 'requires authorization' do
          get :new, school_class_id: school_class
          expect(response).to require_authorization
        end
      end
      describe 'GET #edit' do
        it 'requires authorization' do
          get :edit, id: a_subject
          expect(response).to require_authorization
        end
      end

      describe 'POST #create' do
        it 'requires authorization' do
          post :create, school_class_id: school_class, subject: valid_attributes
          expect(response).to require_authorization
        end
      end

      describe 'PUT #update' do
        it 'requires authorization' do
          put :update, id: a_subject, subject: valid_attributes
          expect(response).to require_authorization
        end
      end

      describe 'DELETE #destroy' do
        it 'requires authorization' do
          delete :destroy, id: a_subject
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
          get :index, school_class_id: school_class
          expect(response).to have_http_status :success
        end
      end

      describe 'GET #show' do
        it 'succeed' do
          get :show, id: a_subject
          expect(response).to have_http_status :success
        end
      end

      describe 'GET #new' do
        it 'succeed' do
          get :new, school_class_id: school_class
          expect(response).to have_http_status :success
        end
      end

      describe 'GET #edit' do
        it 'succeed' do
          get :edit, id: a_subject
          expect(response).to have_http_status :success
        end
      end

      describe 'POST #create' do
        context 'with valid params' do
          it 'creates a new Subject' do
            expect {
              post :create, school_class_id: school_class, subject: valid_attributes
            }.to change(Subject, :count).by(1)
          end

          it 'redirects to the created subject' do
            post :create, school_class_id: school_class, subject: valid_attributes
            expect(response).to redirect_to(Subject.last)
          end
        end

        context 'with invalid params' do
          it 'does not create a new subject' do
            expect {
              post :create, school_class_id: school_class, subject: invalid_attributes
            }.not_to change(Subject, :count)
          end

          it "re-renders the 'new' template" do
            post :create, school_class_id: school_class, subject: invalid_attributes
            expect(response).to render_template('new')
          end
        end
      end

      describe 'PUT #update' do
        context 'with valid params' do
          let(:new_attributes) { attributes_for(:subject, name: 'Math') }

          it 'updates the requested subject' do
            put :update, id: a_subject, subject: new_attributes
            a_subject.reload
            expect(a_subject.name).to eq 'Math'
          end

          it 'redirects to the subject' do
            put :update, id: a_subject, subject: valid_attributes
            expect(response).to redirect_to(a_subject)
          end
        end

        context 'with invalid params' do
          it 'does not change the subject' do
            put :update, id: a_subject, subject: invalid_attributes
            a_subject.reload
            expect(a_subject.name).not_to be_nil
          end

          it "re-renders the 'edit' template" do
            put :update, id: a_subject, subject: invalid_attributes
            expect(response).to render_template('edit')
          end
        end
      end

      describe 'DELETE #destroy' do
        it 'destroys the requested subject' do
          delete :destroy, id: a_subject
          expect(Subject.exists?(a_subject.id)).to be_falsy
        end

        it 'redirects to the subjects list' do
          delete :destroy, id: a_subject
          expect(response).to redirect_to(school_class_subjects_url(school_class))
        end
      end
    end
  end
end
