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

      describe 'GET #edit' do
        context 'day is persisted' do
          it 'succeed' do
            date = Date.current
            Day.make(classroom: classroom, date: date).tap { |d| d.save! }
            get :edit, classroom_id: classroom.id, date: date.to_param
            expect(response).to have_http_status :success
            expect(response).to render_template :edit
          end
        end

        context 'day is not persisted' do
          context 'classrooms has a timetable' do
            let!(:timetable) { create(:timetable, classroom: classroom, periods_number: 2, active: true, weekends: ['Friday']) }

            context 'study day' do
              let(:date) { Date.new 2016, 6, 15 }

              it 'succeed' do
                get :edit, classroom_id: classroom.id, date: date.to_param
                expect(response).to have_http_status :success
                expect(response).to render_template :edit
              end

              it 'creates a new day' do
                expect {
                  get :edit, classroom_id: classroom.id, date: date.to_param
                }.to change(Day, :count).by(1)
              end
            end

            context 'weekend' do
              it 'renders :weekend' do
                date = Date.new 2016, 6, 17
                get :edit, classroom_id: classroom.id, date: date.to_param
                expect(response).to render_template :weekend
              end
            end
          end

          context 'classroom has no timetable' do
            it 'renders :no_timetable' do
              get :edit, classroom_id: classroom.id, date: Date.current.to_param
              expect(response).to render_template :no_timetable
            end
          end
        end
      end

      describe 'PUT #update' do
        let(:date) { Date.current }
        let(:day) { Day.make(classroom: classroom, date: date).tap { |d| d.save! } }

        it 'updates the requested day' do
          expect {
            put :update, id: day, day: { summary: 'OK' }
            day.reload
          }.to change(day, :updated_at)
          expect(day.summary).to eq 'OK'
        end

        it 'redirects to edit form' do
          put :update, id: day, day: { summary: 'OK' }
          expect(response).to redirect_to edit_classroom_agendas_url(classroom_id: classroom, date: date.to_param)
        end

        context 'with ajax' do
          it 'updates the requested day' do
            expect {
              xhr :put, :update, id: day, day: { summary: 'OK' }
              day.reload
            }.to change(day, :updated_at)
            expect(day.summary).to eq 'OK'
          end

          it 'does not redirect to edit form' do
            xhr :put, :update, id: day, day: { summary: 'OK' }
            expect(response).not_to redirect_to edit_classroom_agendas_url(classroom_id: classroom, date: date.to_param)
            expect(response).to have_http_status :success
          end
        end
      end
    end
  end
end
