require 'rails_helper'

RSpec.describe SchoolClassesController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # SchoolClass. As you add validations to SchoolClass, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { attributes_for :school_class }

  let(:invalid_attributes) { attributes_for :invalid_school_class }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # SchoolClassesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  before(:each) do
    @school = create(:school)
    @school_class = create(:school_class, school: @school)
  end

  describe "GET #index" do
    it "assigns all school_classes as @school_classes" do
      get :index, { school_id: @school }, valid_session
      expect(assigns(:school_classes)).to eq([@school_class])
    end
  end

  describe "GET #show" do
    it "assigns the requested school_class as @school_class" do
      get :show, { school_id: @school, id: @school_class }, valid_session
      expect(assigns(:school_class)).to eq(@school_class)
    end
  end

  describe "GET #new" do
    it "assigns a new school_class as @school_class" do
      get :new, { school_id: @school }, valid_session
      expect(assigns(:school_class)).to be_a_new(SchoolClass)
    end
  end

  describe "GET #edit" do
    it "assigns the requested school_class as @school_class" do
      get :edit, { school_id: @school, id: @school_class }, valid_session
      expect(assigns(:school_class)).to eq(@school_class)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new SchoolClass" do
        expect {
          post :create, { school_id: @school, :school_class => valid_attributes }, valid_session
        }.to change(SchoolClass, :count).by(1)
      end

      it "assigns a newly created school_class as @school_class" do
        post :create, { school_id: @school, :school_class => valid_attributes}, valid_session
        expect(assigns(:school_class)).to be_a(SchoolClass)
        expect(assigns(:school_class)).to be_persisted
      end

      it "redirects to the created school_class" do
        post :create, { school_id: @school, :school_class => valid_attributes }, valid_session
        expect(response).to redirect_to([@school, SchoolClass.last])
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved school_class as @school_class" do
        post :create, { school_id: @school, :school_class => invalid_attributes}, valid_session
        expect(assigns(:school_class)).to be_a_new(SchoolClass)
      end

      it "re-renders the 'new' template" do
        post :create, { school_id: @school, :school_class => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { { name: '10-A' } }

      it "updates the requested school_class" do
        put :update, { school_id: @school, id: @school_class, :school_class => new_attributes}, valid_session
        @school_class.reload
        expect(@school_class.name).to eq '10-A'
      end

      it "assigns the requested school_class as @school_class" do
        put :update, { school_id: @school, id: @school_class, :school_class => valid_attributes}, valid_session
        expect(assigns(:school_class)).to eq(@school_class)
      end

      it "redirects to the school_class" do
        put :update, { school_id: @school, id: @school_class, :school_class => valid_attributes}, valid_session
        expect(response).to redirect_to([@school, @school_class])
      end
    end

    context "with invalid params" do
      it "assigns the school_class as @school_class" do
        put :update, { school_id: @school, id: @school_class, :school_class => invalid_attributes}, valid_session
        expect(assigns(:school_class)).to eq(@school_class)
      end

      it "re-renders the 'edit' template" do
        put :update, { school_id: @school, id: @school_class, :school_class => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested school_class" do
      expect {
        delete :destroy, { school_id: @school, id: @school_class }, valid_session
      }.to change(SchoolClass, :count).by(-1)
    end

    it "redirects to the school_classes list" do
      delete :destroy, { school_id: @school, id: @school_class }, valid_session
      expect(response).to redirect_to(school_classes_url)
    end
  end
end
