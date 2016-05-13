require 'rails_helper'

RSpec.describe Classrooms::StudentsController, type: :controller do
  let(:school) { create(:active_school) }
  let(:authorized_user) { create(:school_administration, administrated_school: school).administrator }
  let(:school_class) { create(:school_class, school: school) }
  let(:classroom) { create(:classroom, school_class: school_class) }
  let(:non_authorized_user) { create(:user) }

  let(:valid_attributes) { attributes_for(:student) }
  let(:beginning_date_attributes) { {year: '2015', month: '3', day: '4'} }
  let(:invalid_attributes) { attributes_for(:invalid_student) }

  context 'guest' do
    describe 'GET #new' do
      it 'requires log in' do
        get :new, classroom_id: classroom
        expect(response).to require_login
      end
    end

    describe 'GET #index' do
      it 'requires log in' do
        get :index, classroom_id: classroom
        expect(response).to require_login
      end
    end

    describe 'POST #create' do
      it 'requires log in' do
        post :create, classroom_id: classroom, student: valid_attributes
        expect(response).to require_login
      end
    end
  end

  context 'authenticated user' do
    context 'non authorized' do
      before do
        sign_in non_authorized_user
      end

      describe 'GET #new' do
        it 'requires authoriauthorizations' do
          get :new, classroom_id: classroom
          expect(response).to require_authorization
        end
      end

      describe 'GET #index' do
        it 'requires authorization' do
          get :index, classroom_id: classroom
          expect(response).to require_authorization
        end
      end

      describe 'POST #create' do
        it 'requires authorization' do
          post :create, classroom_id: classroom, student: valid_attributes
          expect(response).to require_authorization
        end
      end
    end

    context 'authorized' do
      before do
        sign_in authorized_user
      end

      describe "GET #new" do
        it "returns http success" do
          get :new, classroom_id: classroom
          expect(response).to have_http_status(:success)
        end
      end

      describe "GET #index" do
        it "returns http success" do
          get :index, classroom_id: classroom
          expect(response).to have_http_status(:success)
        end
      end

      describe 'POST #create' do
        context 'with valid params' do
          it 'creates a new Student' do
            expect {
              post :create, classroom_id: classroom, student: valid_attributes, beginning_date: beginning_date_attributes
            }.to change(Student, :count).by(1)
          end

          it 'redirects to the created student' do
            post :create, classroom_id: classroom, student: valid_attributes, beginning_date: beginning_date_attributes
            expect(response).to redirect_to(Student.last)
          end
        end

        context 'with invalid params' do
          it 'does not create a new student' do
            expect {
              post :create, classroom_id: classroom, student: invalid_attributes, beginning_date: beginning_date_attributes
            }.not_to change(Student, :count)
          end

          it "re-renders the 'new' template" do
            post :create, classroom_id: classroom, student: invalid_attributes, beginning_date: beginning_date_attributes
            expect(response).to render_template('new')
          end
        end
      end
    end
  end
end
