require 'rails_helper'

RSpec.describe ClassroomsController, type: :controller do
  let(:valid_attributes) { attributes_for :classroom }
  let(:invalid_attributes) { attributes_for :invalid_classroom }

  context 'guest access' do
    let(:school) { build_stubbed(:school) }
    let(:school_class) { build_stubbed(:school_class, school: school) }
    let(:classroom) { build_stubbed(:classroom, school_class: school_class) }

    describe 'GET #index' do
      it 'requires login' do
        get :index, school_class_id: school_class
        expect(response).to require_login
      end
    end

    describe 'GET #show' do
      it 'requires login' do
        get :show, id: school_class
        expect(response).to require_login
      end
    end

    describe 'GET #new' do
      it 'requires login' do
        get :new, school_class_id: school_class
        expect(response).to require_login
      end
    end

    describe 'GET #edit' do
      it 'requires login' do
        get :edit, id: school_class
        expect(response).to require_login
      end
    end

    describe 'POST #create' do
      it 'requires login' do
        post :create, school_class_id: school_class, school_class: valid_attributes
        expect(response).to require_login
      end
    end

    describe 'PUT #update' do
      it 'requires login' do
        put :update, id: classroom, school: valid_attributes
        expect(response).to require_login
      end
    end

    describe 'DELETE #destroy' do
      it 'requires login' do
        delete :destroy, id: classroom
        expect(response).to require_login
      end
    end
  end

  context 'authenticated user' do
    let(:school) { create(:school) }
    let(:school_class) { create(:school_class, school: school) }
    let(:classroom) { create(:classroom, school_class: school_class) }
    let(:non_authorized_user) { create(:user) }
    let(:authorized_user) { create(:school_administration, administrated_school: school).administrator }

    context 'not authorized user' do
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
          get :show, id: classroom
          expect(response).to require_authorization
        end
      end

      describe 'GET #new' do
        it 'requires authorization' do
          get :new, school_class_id: classroom
          expect(response).to require_authorization
        end

      end

      describe 'GET #edit' do
        it 'requires authorization' do
          get :edit, id: classroom
          expect(response).to require_authorization
        end

      end

      describe 'POST #create' do
        it 'requires authorization' do
          post :create, school_class_id: school_class, classroom: valid_attributes
          expect(response).to require_authorization
        end
      end

      describe 'PUT #update' do
        it 'requires authorization' do
          put :update, id: classroom, classroom: valid_attributes
          expect(response).to require_authorization
        end
      end

      describe 'DELETE #destroy' do
        it 'requires authorization' do
          delete :destroy, id: classroom
          expect(response).to require_authorization
        end
      end
    end

    context 'authorized user' do
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
          get :show, id: classroom
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
          get :edit, id: classroom
          expect(response).to have_http_status :success
        end
      end

      describe 'POST #create' do
        context 'with valid params' do
          it 'creates a new Classroom' do
            expect {
              post :create, school_class_id: school_class, classroom: valid_attributes
            }.to change(Classroom, :count).by(1)
          end

          it 'redirects to the created classroom' do
            post :create, school_class_id: school_class, classroom: valid_attributes
            expect(response).to redirect_to(Classroom.last)
          end
        end

        context 'with invalid params' do
          it 'does not create a new classroom' do
            expect {
              post :create, school_class_id: school_class, classroom: invalid_attributes
            }.not_to change(Classroom, :count)
          end

          it "re-renders the 'new' template" do
            post :create, school_class_id: school_class, classroom: invalid_attributes
            expect(response).to render_template('new')
          end
        end
      end

      describe 'PUT #update' do
        context 'with valid params' do
          let(:new_attributes) { attributes_for(:classroom, name: '10') }

          it 'updates the requested classroom' do
            put :update, id: classroom, classroom: new_attributes
            classroom.reload
            expect(classroom.name).to eq '10'
          end

          it 'redirects to the classroom' do
            put :update, id: classroom, classroom: valid_attributes
            expect(response).to redirect_to(classroom)
          end
        end

        context 'with invalid params' do
          it 'does not update the requested classroom' do
            put :update, id: classroom, classroom: invalid_attributes
            classroom.reload
            expect(classroom.name).not_to eq ''
          end

          it "re-renders the 'edit' template" do
            put :update, id: classroom, classroom: invalid_attributes
            expect(response).to render_template('edit')
          end
        end
      end

      describe 'DELETE #destroy' do
        it 'destroys the requested classroom' do
          delete :destroy, id: classroom
          expect(Classroom.exists?(classroom.id)).to be_falsy
        end

        it 'redirects to the classrooms list' do
          delete :destroy, id: classroom
          expect(response).to redirect_to(school_class_classrooms_url(school_class))
        end
      end
    end
  end
end
