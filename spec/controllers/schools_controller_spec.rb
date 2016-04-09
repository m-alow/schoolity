require 'rails_helper'

RSpec.describe SchoolsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # School. As you add validations to School, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { attributes_for :school }

  let(:invalid_attributes) { attributes_for :invalid_school }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # SchoolsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all schools as @schools" do
      school = create(:school)
      get :index, {}, valid_session
      expect(assigns(:schools)).to eq([school])
    end
  end

  describe "GET #show" do
    it "assigns the requested school as @school" do
      school = create(:school)
      get :show, {:id => school.to_param}, valid_session
      expect(assigns(:school)).to eq(school)
    end
  end

  describe "GET #new" do
    it "assigns a new school as @school" do
      get :new, {}, valid_session
      expect(assigns(:school)).to be_a_new(School)
    end
  end

  describe "GET #edit" do
    it "assigns the requested school as @school" do
      school = create(:school)
      get :edit, {:id => school.to_param}, valid_session
      expect(assigns(:school)).to eq(school)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new School" do
        expect {
          post :create, {:school => valid_attributes}, valid_session
        }.to change(School, :count).by(1)
      end

      it "assigns a newly created school as @school" do
        post :create, {:school => valid_attributes}, valid_session
        expect(assigns(:school)).to be_a(School)
        expect(assigns(:school)).to be_persisted
      end

      it "redirects to the created school" do
        post :create, {:school => valid_attributes}, valid_session
        expect(response).to redirect_to(School.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved school as @school" do
        post :create, {:school => invalid_attributes}, valid_session
        expect(assigns(:school)).to be_a_new(School)
      end

      it "re-renders the 'new' template" do
        post :create, {:school => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { attributes_for :school }

      it "updates the requested school" do
        school = create(:school)
        put :update, { id: school, school: attributes_for(:school, name: 'S1') }, valid_session
        school.reload
        expect(school.name).to eq 'S1'
      end

      it "assigns the requested school as @school" do
        school = create(:school)
        put :update, {:id => school.to_param, :school => valid_attributes}, valid_session
        expect(assigns(:school)).to eq(school)
      end

      it "redirects to the school" do
        school = create(:school)
        put :update, {:id => school.to_param, :school => valid_attributes}, valid_session
        expect(response).to redirect_to(school)
      end
    end

    context "with invalid params" do
      it "assigns the school as @school" do
        school = create(:school)
        put :update, {:id => school.to_param, :school => invalid_attributes}, valid_session
        expect(assigns(:school)).to eq(school)
      end

      it "re-renders the 'edit' template" do
        school = create(:school)
        put :update, {:id => school.to_param, :school => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested school" do
      school = create(:school)
      expect {
        delete :destroy, {:id => school.to_param}, valid_session
      }.to change(School, :count).by(-1)
    end

    it "redirects to the schools list" do
      school = create(:school)
      delete :destroy, {:id => school.to_param}, valid_session
      expect(response).to redirect_to(schools_url)
    end
  end

end
