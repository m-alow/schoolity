require 'rails_helper'

RSpec.describe LessonsController, type: :controller do
  let!(:lesson) { Lesson.make(subject: create(:subject), day: create(:day), order: 1).tap { |l| l.save! } }
  let(:classroom) { lesson.day.classroom }

  context 'guest' do
    describe 'GET #show' do
      it 'requires login' do
        get :show, id: lesson
        expect(response).to require_login
      end
    end

    describe 'PUT #update' do
      it 'requires login' do
        put :update, id: lesson
        expect(response).to require_login
      end
    end

    describe 'PUT #update_qualified' do
      it 'requires login' do
        put :update_qualified, classroom_id: classroom, date: lesson.day.date, order: '1'
        expect(response).to require_login
      end
    end
  end

  context 'authenticated user' do

    context 'non authorized' do
      let(:non_authorized_user) { create(:user) }
      before { sign_in non_authorized_user }

      describe 'GET #show' do
        it 'requires authorization' do
          get :show, id: lesson
          expect(response).to require_authorization
        end
      end

      describe 'PUT #update' do
        it 'requires authorization' do
          put :update, id: lesson
          expect(response).to require_authorization
        end
      end

      describe 'PUT #update_qualified' do
        it 'requires authorization' do
          put :update_qualified, classroom_id: classroom, date: lesson.day.date, order: '1'
          expect(response).to require_authorization
        end
      end
    end

    context 'authorized' do
      let(:authorized_user) { create(:teaching, classroom: lesson.day.classroom, all_subjects: true).teacher }
      before { sign_in authorized_user }

      describe 'GET #show' do
        it 'succeed' do
          get :show, id: lesson
          expect(response).to have_http_status :success
        end
      end

      describe 'PUT #update' do
        it 'updates the requested lesson' do
          expect {
            put :update, id: lesson, lesson: { title: 'Sum', summary: 'Sum is good for you life.' }
            lesson.reload
          }.to change { lesson.updated_at }

          expect(lesson.title).to eq 'Sum'
        end

        it 'redirects to agendas edit form' do
          put :update, id: lesson, lesson: { title: 'Sum', summary: 'Sum is good for you life.' }
          expect(response).to redirect_to edit_classroom_agendas_url(classroom_id: lesson.day.classroom.id, date: lesson.day.date.to_param)
        end

        context 'with ajax' do
          it 'updates the requested lesson' do
            expect {
              xhr :put, :update, id: lesson, lesson: { title: 'Sum', summary: 'Sum is good for you life.' }
              lesson.reload
            }.to change { lesson.updated_at }

            expect(lesson.title).to eq 'Sum'
          end

          it 'does not redirect to agendas edit form' do
            xhr :put, :update, id: lesson, lesson: { title: 'Sum', summary: 'Sum is good for you life.' }
            expect(response).not_to redirect_to edit_classroom_agendas_url(classroom_id: lesson.day.classroom.id, date: lesson.day.date.to_param)
          end
        end
      end
    end
  end
end
