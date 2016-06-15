require 'rails_helper'

RSpec.describe AgendasController, type: :controller do
  let(:school) { create(:active_school) }
  let(:classroom) { create(:classroom) }
  let(:day) { create(:day)  }

  let(:authorized_user) { classroom.school.owner }
  let(:non_authorized_user) { create(:user) }

  let(:valid_attributes) { {} }
  let(:invalid_attributes) { {} }
  let(:valid_session) { {} }

  context 'guest' do
    describe 'GET #index' do
      it 'require login' do
        get :index, classroom_id: classroom
        expect(response).to require_login
      end
    end

    describe 'GET #show_by_date' do
      it 'require login' do
        get :show_by_date,  classroom_id: classroom, date: day.to_param
        expect(response).to require_login
      end
    end

    describe 'GET #today' do
      it 'require login' do
        get :today, classroom_id: classroom
        expect(response).to require_login
      end
    end

    # describe 'GET #new' do
    #   it 'require login' do
    #     get :new, classroom_id: classroom
    #     expect(response).to require_login
    #   end
    # end

    describe 'GET #edit' do
      it 'require login' do
        get :edit, classroom_id: classroom, date: day.to_param
        expect(response).to require_login
      end
    end

    # describe 'POST #create' do
    #   it 'require login' do
    #     post :create, classroom_id: classroom, agenda: valid_attributes
    #     expect(response).to require_login
    #   end
    # end

    describe 'PUT #update' do
      it 'require login' do
        put :update, id: day, agenda: valid_attributes
        expect(response).to require_login
      end
    end

    describe 'DELETE #destroy' do
      it 'require login' do
        delete :destroy, id: day
        expect(response).to require_login
      end
    end
  end

  context 'authenticated user' do
    context 'non authorized user' do
      before { sign_in non_authorized_user }

      describe 'GET #index' do
        it 'require authorization' do
          get :index, classroom_id: classroom
          expect(response).to require_authorization
        end
      end

      describe 'GET #show_by_date' do
        it 'require authorization' do
          get :show_by_date, classroom_id: classroom, date: '2010-10-10'
          expect(response).to require_authorization
        end
      end

      # describe 'GET #new' do
      #   it 'require authorization' do
      #     get :new, classroom_id: classroom
      #     expect(response).to require_authorization
      #   end
      # end

      describe 'GET #edit' do
        it 'require authorization' do
          get :edit, classroom_id: classroom, date: day.to_param
          expect(response).to require_authorization
        end
      end

      # describe 'POST #create' do
      #   it 'require authorization' do
      #     post :create, classroom_id: classroom, agenda: valid_attributes
      #     expect(response).to require_authorization
      #   end
      # end

      describe 'PUT #update' do
        it 'require authorization' do
          put :update, id: day, agenda: valid_attributes
          expect(response).to require_authorization
        end
      end

      describe 'DELETE #destroy' do
        it 'require authorization' do
          delete :destroy, id: day
          expect(response).to require_authorization
        end
      end
    end

    context 'authorized user' do
      before { sign_in authorized_user }

      describe 'GET #index' do
        it 'succeed' do
          get :index, classroom_id: classroom
          expect(response).to have_http_status :success
        end
      end

      describe 'GET #show_by_date' do
        context 'day is persisted' do
          let(:date) { Date.new 2016, 6, 9 }

          it 'renders :show_by_date' do
            Day.make(classroom: classroom, date: date).save!
            get :show_by_date, classroom_id: classroom, date: date.to_param
            expect(response).to render_template :show_by_date
          end
        end

        context 'day is not persisted' do
          context 'classroom has a current timetable' do
            let!(:timetable) { create(:timetable, classroom: classroom, periods_number: 2, active: true, weekends: ['Friday']) }

            context 'date is a study day' do
              let(:date) { Date.new 2016, 6, 9 }

              it 'renders :show_by_date' do
                get :show_by_date, classroom_id: classroom, date: date.to_param
                expect(response).to render_template :show_by_date
              end
            end

            context 'date is a weekend' do
              it 'renders :weekend' do
                get :show_by_date, classroom_id: classroom, date: '2016-6-10'
                expect(response).to render_template :weekend
              end
            end
          end

          context 'classroom has no current timetable' do
            it 'renders :no_timetable' do
              get :show_by_date, classroom_id: classroom, date: '2010-10-10'
              expect(response).to render_template :no_timetable
            end
          end
        end
      end

      describe 'GET #today' do
        it 'redirects to #show_by_date' do
          Timecop.travel Date.new(2010, 10, 5) do
            get :today, classroom_id: classroom
            expect(response).to redirect_to date_classroom_agendas_url(classroom_id: classroom.id, date: '2010-10-05')
          end
        end
      end
    end
  end

  # describe 'GET #index' do
  #   it 'assigns all agendas as @agendas' do
  #     agenda = Agenda.create! valid_attributes
  #     get :index, {}, valid_session
  #     expect(assigns(:agendas)).to eq([agenda])
  #   end
  # end

  # describe 'GET #show' do
  #   it 'assigns the requested agenda as @agenda' do
  #     agenda = Agenda.create! valid_attributes
  #     get :show, { id: agenda.to_param }, valid_session
  #     expect(assigns(:agenda)).to eq(agenda)
  #   end
  # end

  # describe 'GET #new' do
  #   it 'assigns a new agenda as @agenda' do
  #     get :new, {}, valid_session
  #     expect(assigns(:agenda)).to be_a_new(Agenda)
  #   end
  # end

  # describe 'GET #edit' do
  #   it 'assigns the requested agenda as @agenda' do
  #     agenda = Agenda.create! valid_attributes
  #     get :edit, { id: agenda.to_param }, valid_session
  #     expect(assigns(:agenda)).to eq(agenda)
  #   end
  # end

  # describe 'POST #create' do
  #   context 'with valid params' do
  #     it 'creates a new Agenda' do
  #       expect do
  #         post :create, { agenda: valid_attributes }, valid_session
  #       end.to change(Agenda, :count).by(1)
  #     end

  #     it 'assigns a newly created agenda as @agenda' do
  #       post :create, { agenda: valid_attributes }, valid_session
  #       expect(assigns(:agenda)).to be_a(Agenda)
  #       expect(assigns(:agenda)).to be_persisted
  #     end

  #     it 'redirects to the created agenda' do
  #       post :create, { agenda: valid_attributes }, valid_session
  #       expect(response).to redirect_to(Agenda.last)
  #     end
  #   end

  #   context 'with invalid params' do
  #     it 'assigns a newly created but unsaved agenda as @agenda' do
  #       post :create, { agenda: invalid_attributes }, valid_session
  #       expect(assigns(:agenda)).to be_a_new(Agenda)
  #     end

  #     it "re-renders the 'new' template" do
  #       post :create, { agenda: invalid_attributes }, valid_session
  #       expect(response).to render_template('new')
  #     end
  #   end
  # end

  # describe 'PUT #update' do
  #   context 'with valid params' do
  #     let(:new_attributes) do
  #       skip('Add a hash of attributes valid for your model')
  #     end

  #     it 'updates the requested agenda' do
  #       agenda = Agenda.create! valid_attributes
  #       put :update, { id: agenda.to_param, agenda: new_attributes }, valid_session
  #       agenda.reload
  #       skip('Add assertions for updated state')
  #     end

  #     it 'assigns the requested agenda as @agenda' do
  #       agenda = Agenda.create! valid_attributes
  #       put :update, { id: agenda.to_param, agenda: valid_attributes }, valid_session
  #       expect(assigns(:agenda)).to eq(agenda)
  #     end

  #     it 'redirects to the agenda' do
  #       agenda = Agenda.create! valid_attributes
  #       put :update, { id: agenda.to_param, agenda: valid_attributes }, valid_session
  #       expect(response).to redirect_to(agenda)
  #     end
  #   end

  #   context 'with invalid params' do
  #     it 'assigns the agenda as @agenda' do
  #       agenda = Agenda.create! valid_attributes
  #       put :update, { id: agenda.to_param, agenda: invalid_attributes }, valid_session
  #       expect(assigns(:agenda)).to eq(agenda)
  #     end

  #     it "re-renders the 'edit' template" do
  #       agenda = Agenda.create! valid_attributes
  #       put :update, { id: agenda.to_param, agenda: invalid_attributes }, valid_session
  #       expect(response).to render_template('edit')
  #     end
  #   end
  # end

  # describe 'DELETE #destroy' do
  #   it 'destroys the requested agenda' do
  #     agenda = Agenda.create! valid_attributes
  #     expect do
  #       delete :destroy, { id: agenda.to_param }, valid_session
  #     end.to change(Agenda, :count).by(-1)
  #   end

  #   it 'redirects to the agendas list' do
  #     agenda = Agenda.create! valid_attributes
  #     delete :destroy, { id: agenda.to_param }, valid_session
  #     expect(response).to redirect_to(agendas_url)
  #   end
  # end
end
