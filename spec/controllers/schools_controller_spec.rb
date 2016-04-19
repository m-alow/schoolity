require 'rails_helper'

RSpec.describe SchoolsController, type: :controller do
  let(:valid_attributes) { attributes_for :school }
  let(:invalid_attributes) { attributes_for :invalid_school }
  let(:school) { create(:school) }
  let(:current_user) { @user }

  shared_examples :user_access do
    describe 'GET #index' do
      it 'assigns all schools as @schools' do
        get :index
        expect(assigns(:schools)).to eq([school])
      end
    end

    describe 'GET #show' do
      it 'assigns the requested school as @school' do
        get :show, id: school
        expect(assigns(:school)).to eq(school)
      end
    end

    describe 'GET #new' do
      it 'assigns a new school as @school' do
        get :new
        expect(assigns(:school)).to be_a_new(School)
      end
    end

    describe 'GET #edit' do
      it 'assigns the requested school as @school' do
        get :edit, id: school
        expect(assigns(:school)).to eq(school)
      end
    end

    describe 'POST #create' do
      context 'with valid params' do
        it 'creates a new School' do
          expect {
            post :create, school: valid_attributes
          }.to change(School, :count).by(1)
        end

        it 'assigns a newly created school as @school' do
          post :create, school: valid_attributes
          expect(assigns(:school)).to be_a(School)
          expect(assigns(:school)).to be_persisted
        end

        it 'sets the current user as the owner of the school' do
          post :create, school: valid_attributes
          expect(assigns(:school).owner).to eq @user
        end

        it 'redirects to the created school' do
          post :create, school: valid_attributes
          expect(response).to redirect_to(School.last)
        end
      end

      context 'with invalid params' do
        it 'assigns a newly created but unsaved school as @school' do
          post :create, school: invalid_attributes
          expect(assigns(:school)).to be_a_new(School)
        end

        it "re-renders the 'new' template" do
          post :create, school: invalid_attributes
          expect(response).to render_template('new')
        end
      end
    end

    describe 'PUT #update' do
      context 'with valid params' do
        let(:new_attributes) { attributes_for :school }

        it 'updates the requested school' do
          put :update, id: school, school: attributes_for(:school, name: 'S1')
          school.reload
          expect(school.name).to eq 'S1'
        end

        it 'assigns the requested school as @school' do
          put :update, id: school, school: valid_attributes
          expect(assigns(:school)).to eq(school)
        end

        it 'redirects to the school' do
          put :update, id: school, school: valid_attributes
          expect(response).to redirect_to(school)
        end
      end

      context 'with invalid params' do
        it 'assigns the school as @school' do
          put :update, id: school, school: invalid_attributes
          expect(assigns(:school)).to eq(school)
        end

        it "re-renders the 'edit' template" do
          put :update, id: school, school: invalid_attributes
          expect(response).to render_template('edit')
        end
      end
    end

    describe 'DELETE #destroy' do
      it 'destroys the requested school' do
        school
        expect {
          delete :destroy, id: school
        }.to change(School, :count).by(-1)
      end

      it 'redirects to the schools list' do
        delete :destroy, id: school
        expect(response).to redirect_to(schools_url)
      end
    end
  end

  context 'guest access' do
    let(:school) { build_stubbed(:school) }
    describe 'GET #index' do
      it 'requires login' do
        get :index
        expect(response).to require_login
      end
    end

    describe 'GET #show' do
      it 'requires login' do
        get :show, id: school
        expect(response).to require_login
      end
    end

    describe 'GET #new' do
      it 'requires login' do
        get :new
        expect(response).to require_login
      end
    end

    describe 'GET #edit' do
      it 'requires login' do
        get :edit, id: school
        expect(response).to require_login
      end
    end

    describe 'POST #create' do
      it 'requires login' do
        post :create, school: valid_attributes
        expect(response).to require_login
      end
    end

    describe 'PUT #update' do
      it 'requires login' do
        put :update, id: school, school: valid_attributes
        expect(response).to require_login
      end
    end

    describe 'DELETE #destroy' do
      it 'requires login' do
        delete :destroy, id: school
        expect(response).to require_login
      end
    end

    describe 'PUT #activate' do
      it 'requires login' do
        put :activate, id: school
        expect(response).to require_login
      end
    end
  end

  context 'user access' do
    before(:each) do
      @user = create(:user)
      sign_in @user
    end

    it_behaves_like :user_access

    describe 'PUT #activate' do
      it 'does not activate the requested school' do
        put :activate, id: school, school: { active: true }
        school.reload
        expect(school.active?).to be false
      end

      it 'assigns the requested school as @school' do
        put :activate, id: school, school: { active: true }
        expect(assigns(:school)).to eq(school)
      end

      it 'require authorization' do
        put :activate, id: school, school: { active: true }
        expect(response).to redirect_to(root_url)
      end
    end
  end

  context 'admin access' do
    before(:each) do
      @user = create(:admin)
      sign_in @user
    end

    it_behaves_like :user_access

    describe 'PUT #activate' do
      it 'updates the requested school' do
        put :activate, id: school, school: { active: true }
        school.reload
        expect(school.active?).to be true
      end

      it 'assigns the requested school as @school' do
        put :activate, id: school, school: { active: true }
        expect(assigns(:school)).to eq(school)
      end

      it 'redirects to the school' do
        put :activate, id: school, school: { active: true }
        expect(response).to redirect_to(school)
      end
    end
  end
end
