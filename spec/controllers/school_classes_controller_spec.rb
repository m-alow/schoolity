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
        get :show, id: school_class, school_id: school
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
        get :edit, id: school_class, school_id: school
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
        put :update, id: school, school_id: school, school: valid_attributes
        expect(response).to require_login
      end
    end

    describe 'DELETE #destroy' do
      it 'requires login' do
        delete :destroy, id: school, school_id: school
        expect(response).to require_login
      end
    end
  end

  context 'user access' do
    before(:each) do
      @user = create(:user)
      sign_in @user
    end

    let(:school) { create(:school) }
    let(:school_class) { create(:school_class, school: school) }

    describe 'GET #index' do
      it 'assigns all school_classes as @school_classes' do
        get :index, school_id: school
        expect(assigns(:school_classes)).to eq([school_class])
      end
    end

    describe 'GET #show' do
      it 'assigns the requested school_class as @school_class' do
        get :show, school_id: school, id: school_class
        expect(assigns(:school_class)).to eq(school_class)
      end
    end

    describe 'GET #new' do
      it 'assigns a new school_class as @school_class' do
        get :new, school_id: school
        expect(assigns(:school_class)).to be_a_new(SchoolClass)
      end
    end

    describe 'GET #edit' do
      it 'assigns the requested school_class as @school_class' do
        get :edit, school_id: school, id: school_class
        expect(assigns(:school_class)).to eq(school_class)
      end
    end

    describe 'POST #create' do
      context 'with valid params' do
        it 'creates a new SchoolClass' do
          expect {
            post :create, school_id: school, school_class: valid_attributes
          }.to change(SchoolClass, :count).by(1)
        end

        it 'assigns a newly created school_class as @school_class' do
          post :create, school_id: school, school_class: valid_attributes
          expect(assigns(:school_class)).to be_a(SchoolClass)
          expect(assigns(:school_class)).to be_persisted
        end

        it 'redirects to the created school_class' do
          post :create, school_id: school, school_class: valid_attributes
          expect(response).to redirect_to([school, SchoolClass.last])
        end
      end

      context 'with invalid params' do
        it 'assigns a newly created but unsaved school_class as @school_class' do
          post :create, school_id: school, school_class: invalid_attributes
          expect(assigns(:school_class)).to be_a_new(SchoolClass)
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
          put :update, school_id: school, id: school_class, school_class: new_attributes
          school_class.reload
          expect(school_class.name).to eq '10-A'
        end

        it 'assigns the requested school_class as @school_class' do
          put :update, school_id: school, id: school_class, school_class: valid_attributes
          expect(assigns(:school_class)).to eq(school_class)
        end

        it 'redirects to the school_class' do
          put :update, school_id: school, id: school_class, school_class: valid_attributes
          expect(response).to redirect_to([school, school_class])
        end
      end

      context 'with invalid params' do
        it 'assigns the school_class as @school_class' do
          put :update, school_id: school, id: school_class, school_class: invalid_attributes
          expect(assigns(:school_class)).to eq(school_class)
        end

        it "re-renders the 'edit' template" do
          put :update, school_id: school, id: school_class, school_class: invalid_attributes
          expect(response).to render_template('edit')
        end
      end
    end

    describe 'DELETE #destroy' do
      it 'destroys the requested school_class' do
        school_class
        expect {
          delete :destroy, school_id: school, id: school_class
        }.to change(SchoolClass, :count).by(-1)
      end

      it 'redirects to the school_classes list' do
        delete :destroy, school_id: school, id: school_class
        expect(response).to redirect_to(school_classes_url)
      end
    end
  end
end
