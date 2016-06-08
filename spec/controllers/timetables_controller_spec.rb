require 'rails_helper'

RSpec.describe TimetablesController, type: :controller do
  let(:classroom) { create(:classroom) }
  let(:timetable) { create(:timetable, classroom: classroom, active: true, periods_number: 1, weekends: ['Friday', 'Saturday', 'Sunday', 'Tuesday', 'Wednesday', 'Thursday']) }
  let(:math) { create(:subject, school_class: classroom.school_class, name: 'Math') }
  let(:physics) { create(:subject, school_class: classroom.school_class, name: 'Physics') }

  let(:non_authorized_user) { create(:user) }
  let(:authorized_user) { create(:school_administration, administrated_school: classroom.school).administrator }

  let(:valid_attributes) { { timetable: { active: '1' }, Monday: { '1' => { period: { subject_id: math.id } } } } }
  let(:valid_new_attributes) { { timetable: { periods_number: 2, Friday: 'Friday' } } }
  let(:invalid_new_attributes) { { timetable: { periods_number: -1}, Friday: 'Friday' } }

  context 'guest' do
    describe 'GET #index' do
      it 'requires login' do
        get :index, classroom_id: classroom
        expect(response).to require_login
      end
    end

    describe 'GET #show' do
      it 'requires login' do
        get :show, id: Timetable
        expect(response).to require_login
      end
    end

    describe 'GET #init' do
      it 'requires login' do
        get :init, classroom_id: classroom
        expect(response).to require_login
      end
    end

    describe 'GET #new' do
      it 'requires login' do
        get :new, classroom_id: classroom
        expect(response).to require_login
      end
    end

    describe 'GET #edit' do
      it 'requires login' do
        get :edit, id: timetable
        expect(response).to require_login
      end
    end

    describe 'POST #create' do
      it 'requires login' do
        post :create, classroom_id: classroom, timetable: valid_attributes
        expect(response).to require_login
      end
    end

    describe 'PUT #update' do
      it 'requires login' do
        put :update, id: timetable, timetable: valid_attributes
        expect(response).to require_login
      end
    end

    describe 'DELETE #destroy' do
      it 'requires login' do
        delete :destroy, id: timetable
        expect(response).to require_login
      end
    end
  end

  context 'authenticated user' do
    context 'non authorized' do
      before { sign_in non_authorized_user }

      describe 'GET #index' do
        it 'requires authorization' do
          get :index, classroom_id: classroom
          expect(response).to require_authorization
        end
      end

      describe 'GET #show' do
        it 'requires authorization' do
          get :show, id: timetable
          expect(response).to require_authorization
        end
      end

      describe 'GET #init' do
        it 'requires authorization' do
          get :init, classroom_id: classroom
          expect(response).to require_authorization
        end
      end

      describe 'GET #new' do
        it 'requires authorization' do
          get :new, classroom_id: classroom
          expect(response).to require_authorization
        end
      end

      describe 'GET #edit' do
        it 'requires authorization' do
          get :edit, id: timetable
          expect(response).to require_authorization
        end
      end

      describe 'POST #create' do
        it 'requires authorization' do
          post :create, classroom_id: classroom, timetable: valid_attributes
          expect(response).to require_authorization
        end
      end

      describe 'DELETE #destroy' do
        it 'requires authorization' do
          delete :destroy, id: timetable
          expect(response).to require_authorization
        end
      end
    end

    context 'authorized' do
      before { sign_in authorized_user }

      describe 'GET #index' do
        it 'succeed' do
          get :index, classroom_id: classroom
          expect(response).to have_http_status :success
        end
      end

      describe 'GET #show' do
        it 'assigns the requested timetable as @timetable' do
          get :show, id: timetable
          expect(response).to have_http_status :success
        end
      end

      describe 'GET #init' do
        it 'succeed' do
          get :init, classroom_id: classroom
          expect(response).to have_http_status :success
        end
      end

      describe 'GET #new' do
        it 'succeed' do
          get :new, classroom_id: classroom
          expect(response).to have_http_status :success
        end
      end

      describe 'GET #edit' do
        it 'assigns the requested timetable as @timetable' do
          get :edit, id: timetable
          expect(assigns(:timetable)).to eq(timetable)
        end
      end

      describe 'POST #create' do
        context 'with valid params' do
          before do
            session[:weekends] = ['Friday', 'Saturday', 'Sunday', 'Tuesday', 'Wednesday', 'Thursday']
            session[:periods_number] = '1'
          end

          it 'creates a new Timetable' do
            expect {
              post :create, classroom_id: classroom, **valid_attributes
            }.to change(Timetable, :count).by(1)
          end

          it 'creates a new Period' do
            expect {
              post :create, classroom_id: classroom, **valid_attributes
            }.to change(Period, :count).by(1)
          end

          it 'redirects to the created timetable' do
            post :create, classroom_id: classroom, **valid_attributes
            expect(response).to redirect_to(Timetable.last)
          end
        end

        context 'with invalid params' do
          before do
            session[:weekends] = ['Friday', 'Saturday', 'Sunday', 'Tuesday', 'Wednesday', 'Thursday']
            session[:periods_number] = '-1'
          end

          it 'does not create a new timetable' do
            expect {
              post :create, classroom_id: classroom, **valid_attributes
            }.not_to change(Timetable, :count)
          end

          it 'does not create a new Period' do
            expect {
              post :create, classroom_id: classroom, **valid_attributes
            }.not_to change(Period, :count)
          end

          it "re-renders the 'new' template" do
            post :create, classroom_id: classroom, **valid_attributes
            expect(response).to render_template('new')
          end
        end
      end

      describe 'PUT #update' do
        before do
          timetable.periods.create!(subject: math, order: 1, day: 'Monday')
        end

        context 'with valid params' do
          let(:new_attributes) { { timetable: { active: '0' }, Monday: { '1' => { period: { subject_id: physics.id } } } } }

          it 'updates the requested timetable' do
            put :update, id: timetable, **new_attributes
            timetable.reload
            expect(timetable.active?).to be false
          end

          it 'updates the requested period' do
            put :update, id: timetable, **new_attributes
            timetable.reload
            expect(timetable.periods.first.subject.name).to eq 'Physics'
          end

          it 'redirects to the timetable' do
            put :update, id: timetable.to_param, **new_attributes
            expect(response).to redirect_to(timetable)
          end
        end

        context 'with invalid params' do
          let(:new_attributes) { { Monday: { '1' => { period: { subject_id: physics.id } } } } }

          it 'does not update the requested timetable' do
            put :update, id: timetable, **new_attributes
            timetable.reload
            expect(timetable.active?).not_to be false
          end

          it 'does not update the requested period' do
            put :update, id: timetable, **new_attributes
            timetable.reload
            expect(timetable.periods.first.subject.name).not_to eq 'Physics'
          end

          it "re-renders the 'edit' template" do
            put :update, id: timetable, **new_attributes
            expect(response).to render_template('edit')
          end
        end
      end

      describe 'DELETE #destroy' do
        it 'destroys the requested timetable' do
          delete :destroy, id: timetable
          expect(Timetable.exists?(timetable.id)).to be false
        end

        it 'redirects to the timetables list' do
          delete :destroy, id: timetable
          expect(response).to redirect_to(classroom_timetables_url(classroom))
        end
      end
     end
   end
 end
