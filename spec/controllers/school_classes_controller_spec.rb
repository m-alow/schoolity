require 'rails_helper'

RSpec.describe SchoolClassesController, type: :controller do
  let(:valid_attributes) { attributes_for :school_class }
  let(:invalid_attributes) { attributes_for :invalid_school_class }

  context 'guest access' do
    let(:school) { build_stubbed(:school) }
    let(:school_class) { build_stubbed(:school_class, school: school) }

    describe 'GET #index' do
      it 'requires login' do
        get :index, school_id: school
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
        get :new, school_id: school
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
        post :create, school_id: school, school_class: valid_attributes
        expect(response).to require_login
      end
    end

    describe 'PUT #update' do
      it 'requires login' do
        put :update, id: school_class, school: valid_attributes
        expect(response).to require_login
      end
    end

    describe 'DELETE #destroy' do
      it 'requires login' do
        delete :destroy, id: school_class
        expect(response).to require_login
      end
    end
  end

  context 'authenticated user' do
    context 'not authorized' do
      let(:user) { create :user }
      let(:school) { create(:school, active: true) }
      let(:school_class) { create(:school_class, school: school) }

      before do
        sign_in user
      end

      describe 'GET #index' do
        it 'requires authorization' do
          get :index, school_id: school
          expect(response).to require_authorization
        end
      end

      describe 'GET #show' do
        it 'requires authorization' do
          get :show, id: school_class
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
          get :edit, id: school_class
          expect(response).to require_authorization
        end
      end

      describe 'POST #create' do
        it 'requires authorization' do
          post :create, school_id: school, school_class: attributes_for(:school_class)
          expect(response).to require_authorization
        end
      end

      describe 'PUT #update' do
        it 'requires authorization' do
          put :update, id: school_class, school_class: attributes_for(:school_class)
          expect(response).to require_authorization
        end
      end

      describe 'DELETE #destroy' do
        it 'requires authorization' do
          delete :destroy, id: school_class
          expect(response).to require_authorization
        end
      end
    end

    context 'authorized' do
      let(:user) { create(:user) }
      let(:school) { create(:school, active: true, owner: user) }
      let(:school_class) { create(:school_class, school: school) }

      before do
        sign_in user
      end

      describe 'GET #index' do
        it 'succeed' do
          get :index, school_id: school
          expect(response.status).to equal 200
        end
      end

      describe 'GET #show' do
        it 'succeed' do
          get :show, id: school_class
          expect(response.status).to equal 200
        end
      end

      describe 'GET #new' do
        it 'succeed' do
          get :new, school_id: school
          expect(response.status).to equal 200
        end
      end

      describe 'GET #edit' do
        it 'succeed' do
          get :edit, id: school_class
          expect(response.status).to equal 200
        end
      end

      describe 'POST #create' do
        context 'with valid params' do
          it 'creates a new SchoolClass' do
            expect {
              post :create, school_id: school, school_class: valid_attributes
            }.to change(SchoolClass, :count).by(1)
          end

          it 'redirects to the created school_class' do
            post :create, school_id: school, school_class: valid_attributes
            expect(response).to redirect_to(SchoolClass.last)
          end
        end

        context 'with invalid params' do
          it 'does not change the database' do
            expect {
              post :create, school_id: school, school_class: invalid_attributes
            }.not_to change(SchoolClass, :count)
          end

          it "re-renders the 'new' template" do
            post :create, school_id: school, school_class: invalid_attributes
            expect(response).to render_template('new')
          end
        end
      end

      describe 'PUT #update' do
        context 'with valid params' do
          let(:new_attributes) { { name: '10-A' } }

          it 'updates the requested school_class' do
            put :update, id: school_class, school_class: new_attributes
            school_class.reload
            expect(school_class.name).to eq '10-A'
          end

          it 'redirects to the school_class' do
            put :update, id: school_class, school_class: valid_attributes
            expect(response).to redirect_to(school_class)
          end
        end

        context 'with invalid params' do
          it 'does not updates the requested school class' do
            put :update, id: school_class, school_class: { name: '' }
            school_class.reload
            expect(school_class.name).not_to be_nil
          end

          it "re-renders the 'edit' template" do
            put :update, id: school_class, school_class: invalid_attributes
            expect(response).to render_template('edit')
          end
        end
      end

      describe 'DELETE #destroy' do
        it 'destroys the requested school_class' do
          delete :destroy, id: school_class
          expect(SchoolClass.exists?(school_class.id)).to be_falsy
        end

        it 'redirects to the school_classes list' do
          delete :destroy, id: school_class
          expect(response).to redirect_to(school_school_classes_url(school))
        end
      end
    end
  end
end
