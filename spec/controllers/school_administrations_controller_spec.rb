require 'rails_helper'

RSpec.describe SchoolAdministrationsController, type: :controller do
  let(:valid_attributes) { attributes_for(:school_administration) }
  let(:invalid_attributes) { attributes_for(:invalid_school_administration) }

  let(:school_administration) { create(:school_administration) }
  let(:school) { school_administration.administrated_school }
  let(:school_admin) { school_administration.administrator }
  let(:user) { create(:user) }
  let(:admin) { create(:admin) }

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

    describe 'GET #edit' do
      it 'requires log in' do
        get :edit, id: school_administration
        expect(response).to require_login
      end
    end

    describe 'POST #create' do
      it 'requires log in' do
        post :create, school_id: school, school_administration: valid_attributes
        expect(response).to require_login
      end
    end

    describe 'PUT #update' do
      it 'requires log in' do
        put :update, id: school_administration, school_administration: valid_attributes
      end
    end

    describe 'DELETE #destroy' do
      it 'requires log in' do
        delete :destroy, id: school_administration
        expect(response).to require_login
      end
    end
  end

  # context 'admin' do
  #   before(:each) do
  #     sign_in admin
  #   end

  #   describe "GET #index" do
  #     it "assigns all school_administrations as @school_administrations" do
  #       sign_in school_admin
  #       get :index, school_id: school
  #       expect(assigns(:school_administrations)).to eq([school_administration])
  #     end
  #   end

  #   describe "GET #show" do
  #     it "assigns the requested school_administration as @school_administration" do
  #       school_administration = SchoolAdministration.create! valid_attributes
  #       get :show, {:id => school_administration.to_param}
  #       expect(assigns(:school_administration)).to eq(school_administration)
  #     end
  #   end

  #   describe "GET #new" do
  #     it "assigns a new school_administration as @school_administration" do
  #       get :new, {}
  #       expect(assigns(:school_administration)).to be_a_new(SchoolAdministration)
  #     end
  #   end

  #   describe "GET #edit" do
  #     it "assigns the requested school_administration as @school_administration" do
  #       school_administration = SchoolAdministration.create! valid_attributes
  #       get :edit, {:id => school_administration.to_param}
  #       expect(assigns(:school_administration)).to eq(school_administration)
  #     end
  #   end

  #   describe "POST #create" do
  #     context "with valid params" do
  #       it "creates a new SchoolAdministration" do
  #         expect {
  #           post :create, {:school_administration => valid_attributes}
  #         }.to change(SchoolAdministration, :count).by(1)
  #       end

  #       it "assigns a newly created school_administration as @school_administration" do
  #         post :create, {:school_administration => valid_attributes}
  #         expect(assigns(:school_administration)).to be_a(SchoolAdministration)
  #         expect(assigns(:school_administration)).to be_persisted
  #       end

  #       it "redirects to the created school_administration" do
  #         post :create, {:school_administration => valid_attributes}
  #         expect(response).to redirect_to(SchoolAdministration.last)
  #       end
  #     end

  #     context "with invalid params" do
  #       it "assigns a newly created but unsaved school_administration as @school_administration" do
  #         post :create, {:school_administration => invalid_attributes}
  #         expect(assigns(:school_administration)).to be_a_new(SchoolAdministration)
  #       end

  #       it "re-renders the 'new' template" do
  #         post :create, {:school_administration => invalid_attributes}
  #         expect(response).to render_template("new")
  #       end
  #     end
  #   end

  #   describe "PUT #update" do
  #     context "with valid params" do
  #       let(:new_attributes) {
  #         skip("Add a hash of attributes valid for your model")
  #       }

  #       it "updates the requested school_administration" do
  #         school_administration = SchoolAdministration.create! valid_attributes
  #         put :update, {:id => school_administration.to_param, :school_administration => new_attributes}
  #         school_administration.reload
  #         skip("Add assertions for updated state")
  #       end

  #       it "assigns the requested school_administration as @school_administration" do
  #         school_administration = SchoolAdministration.create! valid_attributes
  #         put :update, {:id => school_administration.to_param, :school_administration => valid_attributes}
  #         expect(assigns(:school_administration)).to eq(school_administration)
  #       end

  #       it "redirects to the school_administration" do
  #         school_administration = SchoolAdministration.create! valid_attributes
  #         put :update, {:id => school_administration.to_param, :school_administration => valid_attributes}
  #         expect(response).to redirect_to(school_administration)
  #       end
  #     end

  #     context "with invalid params" do
  #       it "assigns the school_administration as @school_administration" do
  #         school_administration = SchoolAdministration.create! valid_attributes
  #         put :update, {:id => school_administration.to_param, :school_administration => invalid_attributes}
  #         expect(assigns(:school_administration)).to eq(school_administration)
  #       end

  #       it "re-renders the 'edit' template" do
  #         school_administration = SchoolAdministration.create! valid_attributes
  #         put :update, {:id => school_administration.to_param, :school_administration => invalid_attributes}
  #         expect(response).to render_template("edit")
  #       end
  #     end
  #   end

  #   describe "DELETE #destroy" do
  #     it "destroys the requested school_administration" do
  #       school_administration = SchoolAdministration.create! valid_attributes
  #       expect {
  #         delete :destroy, {:id => school_administration.to_param}
  #       }.to change(SchoolAdministration, :count).by(-1)
  #     end

  #     it "redirects to the school_administrations list" do
  #       school_administration = SchoolAdministration.create! valid_attributes
  #       delete :destroy, {:id => school_administration.to_param}
  #       expect(response).to redirect_to(school_administrations_url)
  #     end
  #   end
  # end
end
