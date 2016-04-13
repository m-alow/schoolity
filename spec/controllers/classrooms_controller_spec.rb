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
        get :index, school_id: school, school_class_id: school_class
        expect(response).to require_login
      end
    end

    describe 'GET #show' do
      it 'requires login' do
        get :show, id: school_class, school_id: school, school_class_id: school_class
        expect(response).to require_login
      end
    end

    describe 'GET #new' do
      it 'requires login' do
        get :new, school_id: school, school_class_id: school_class
        expect(response).to require_login
      end
    end

    describe 'GET #edit' do
      it 'requires login' do
        get :edit, id: school_class, school_id: school, school_class_id: school_class
        expect(response).to require_login
      end
    end

    describe 'POST #create' do
      it 'requires login' do
        post :create, school_id: school, school_class_id: school_class, school_class: valid_attributes
        expect(response).to require_login
      end
    end

    describe 'PUT #update' do
      it 'requires login' do
        put :update, id: school, school_id: school, school_class_id: school_class, school: valid_attributes
        expect(response).to require_login
      end
    end

    describe 'DELETE #destroy' do
      it 'requires login' do
        delete :destroy, id: school, school_id: school, school_class_id: school_class
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
    let(:classroom) { create(:classroom, school_class: school_class) }

    describe 'GET #index' do
      it 'assigns all classrooms as @classrooms' do
        get :index, school_id: school, school_class_id: school_class
        expect(assigns(:classrooms)).to eq([classroom])
      end
    end

    describe 'GET #show' do
      it 'assigns the requested classroom as @classroom' do
        get :show, school_id: school, school_class_id: school_class, id: classroom
        expect(assigns(:classroom)).to eq(classroom)
      end
    end

    describe 'GET #new' do
      it 'assigns a new classroom as @classroom' do
        get :new, school_id: school, school_class_id: school_class
        expect(assigns(:classroom)).to be_a_new(Classroom)
      end
    end

    describe 'GET #edit' do
      it 'assigns the requested classroom as @classroom' do
        get :edit, school_id: school, school_class_id: school_class, id: classroom
        expect(assigns(:classroom)).to eq(classroom)
      end
    end

    describe 'POST #create' do
      context 'with valid params' do
        it 'creates a new Classroom' do
          expect {
            post :create, school_id: school, school_class_id: school_class, classroom: valid_attributes
          }.to change(Classroom, :count).by(1)
        end

        it 'assigns a newly created classroom as @classroom' do
          post :create, school_id: school, school_class_id: school_class, classroom: valid_attributes
          expect(assigns(:classroom)).to be_a(Classroom)
          expect(assigns(:classroom)).to be_persisted
        end

        it 'redirects to the created classroom' do
          post :create, school_id: school, school_class_id: school_class, classroom: valid_attributes
          expect(response).to redirect_to([school, school_class, Classroom.last])
        end
      end

      context 'with invalid params' do
        it 'assigns a newly created but unsaved classroom as @classroom' do
          post :create, school_id: school, school_class_id: school_class, classroom: invalid_attributes
          expect(assigns(:classroom)).to be_a_new(Classroom)
        end

        it "re-renders the 'new' template" do
          post :create, school_id: school, school_class_id: school_class, classroom: invalid_attributes
          expect(response).to render_template('new')
        end
      end
    end

    describe 'PUT #update' do
      context 'with valid params' do
        let(:new_attributes) { attributes_for(:classroom, name: '10') }

        it 'updates the requested classroom' do
          put :update, school_id: school, school_class_id: school_class, id: classroom, classroom: new_attributes
          classroom.reload
          expect(classroom.name).to eq '10'
        end

        it 'assigns the requested classroom as @classroom' do
          put :update, school_id: school, school_class_id: school_class, id: classroom, classroom: valid_attributes
          expect(assigns(:classroom)).to eq(classroom)
        end

        it 'redirects to the classroom' do
          put :update, school_id: school, school_class_id: school_class, id: classroom, classroom: valid_attributes
          expect(response).to redirect_to([school, school_class, classroom])
        end
      end

      context 'with invalid params' do
        it 'assigns the classroom as @classroom' do
          put :update, school_id: school, school_class_id: school_class, id: classroom, classroom: invalid_attributes
          expect(assigns(:classroom)).to eq(classroom)
        end

        it "re-renders the 'edit' template" do
          put :update, school_id: school, school_class_id: school_class, id: classroom, classroom: invalid_attributes
          expect(response).to render_template('edit')
        end
      end
    end

    describe 'DELETE #destroy' do
      it 'destroys the requested classroom' do
        classroom
        expect {
          delete :destroy, school_id: school, school_class_id: school_class, id: classroom
        }.to change(Classroom, :count).by(-1)
      end

      it 'redirects to the classrooms list' do
        delete :destroy, school_id: school, school_class_id: school_class, id: classroom
        expect(response).to redirect_to(classrooms_url)
      end
    end
  end
end
