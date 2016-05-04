require 'rails_helper'

RSpec.describe SchoolAdministrationsController, type: :controller do
  let(:valid_attributes) {  user.email }
  let(:invalid_attributes) { 'non-existent@mail.com' }

  let(:school_administration) { create(:school_administration, administrated_school: school, administrator: school_admin) }
  let(:school) { create(:school, owner: owner) }
  let(:school_admin) { create(:user) }
  let(:user) { create(:user) }
  let(:admin) { create(:admin) }
  let(:owner) { create(:user) }

  context 'guest' do
    describe 'GET #index' do
      it 'requires log in' do
        get :index, school_id: school
        expect(response).to require_login
      end
    end

    describe 'GET #show' do
      it 'requires log in' do
        get :show, id: school_administration
        expect(response).to require_login
      end
    end

    describe 'GET #new' do
      it 'requires log in' do
        get :new, school_id: school
        expect(response).to require_login
      end
    end

    describe 'POST #create' do
      it 'requires log in' do
        post :create, school_id: school, school_administration: valid_attributes
        expect(response).to require_login
      end
    end

    describe 'DELETE #destroy' do
      it 'requires log in' do
        delete :destroy, id: school_administration
        expect(response).to require_login
      end
    end
  end

  context 'authenticated user' do
    context 'not authorized' do
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
          get :show, id: school_administration
          expect(response).to require_authorization
        end
      end

      describe 'GET #new' do
        it 'requires authorization' do
          get :new, school_id: school
          expect(response).to require_authorization
        end
      end

      describe 'POST #create' do
        it 'requires authorization' do
          post :create, school_id: school, school_administration: { administrator_id: user }
          expect(response).to require_authorization
        end
      end

      describe 'DELETE #destroy' do
        it 'requires authorization' do
          delete :destroy, id: school_administration
          expect(response).to require_authorization
        end
      end
    end

    context 'authorized' do
      before do
        sign_in owner
      end

      describe 'GET #index' do
        it 'succeed' do
          get :index, school_id: school
          expect(response.status).to be 200
        end
      end

      describe 'GET #show' do
        it 'succeed' do
          get :show, id: school_administration
          expect(response.status).to be 200
        end
      end

      describe 'GET #new' do
        it 'succeed' do
          get :new, school_id: school
          expect(response.status).to be 200
        end
      end

      describe 'POST #create' do
        context 'with valid params' do
          it 'creates a new school administration' do
            expect {
              post :create, school_id: school, email: valid_attributes
            }.to change(SchoolAdministration, :count).by(1)
          end

          it 'redirects to the created school_class' do
            post :create, school_id: school, email: valid_attributes
            expect(response).to redirect_to(SchoolAdministration.last)
          end
        end

        context 'with invalid params' do
          it 'does not change the database' do
            expect {
              post :create, school_id: school, email: invalid_attributes
            }.not_to change(SchoolAdministration, :count)
          end

          it "re-renders the 'new' template" do
            post :create, school_id: school, email: invalid_attributes
            expect(response).to render_template('new')
          end
        end
      end

      describe 'DELETE #destroy' do
        it 'destroys the requested school administration' do
          delete :destroy, id: school_administration
          expect(SchoolAdministration.exists?(school_administration.id)).to be_falsy
        end

        it 'redirects to the school_classes list' do
          delete :destroy, id: school_administration
          expect(response).to redirect_to(school_school_administrations_url(school))
        end
      end
    end
  end
end
