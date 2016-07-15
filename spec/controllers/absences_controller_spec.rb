require 'rails_helper'

RSpec.describe AbsencesController, type: :controller do
  let(:classroom) { create(:classroom) }
  let(:student) { create(:studying, classroom: classroom).student }
  let(:date) { Date.current }
  let(:day) { Day.make(classroom: classroom, date: date).tap { |d| d.save! } }
  let(:absence) { create(:absence, student: student, day: day) }

  context 'guest' do
    describe 'GET #index' do
      it 'requires login' do
        get :index, day_id: day
        expect(response).to require_login
      end
    end

    describe 'PUT #upadte' do
      it 'requires login' do
        put :update, day_id: day, student_id: student
        expect(response).to require_login
      end
    end

    describe 'DELETE #destroy' do
      it 'requires login' do
        delete :destroy, id: absence
        expect(response).to require_login
      end
    end
  end

  context 'authenticated user' do

    context 'non authorized' do
      before { sign_in create(:user) }

      describe 'GET #index' do
        it 'requires authorization' do
          get :index, day_id: day
          expect(response).to require_authorization
        end
      end

      describe 'PUT #upadte' do
        it 'requires authorization' do
          put :update, day_id: day, student_id: student
          expect(response).to require_authorization
        end
      end

      describe 'DELETE #destroy' do
        it 'requires authorization' do
          delete :destroy, id: absence
          expect(response).to require_authorization
        end
      end
    end

    context 'authorized' do
      let(:authorized_user) { classroom.school.owner }
      before { sign_in authorized_user }

      describe 'GET #index' do
        it 'succeed' do
          get :index, day_id: day
          expect(response).to have_http_status :success
        end
      end

      describe 'PUT #update' do
        let(:attributes) { { notes: 'Good' } }

        context 'absence is present' do
          let!(:absence) { create :absence, day: day, student: student, notes: 'Bad' }

          it 'does not create a new absence' do
            expect {
              put :update, day_id: day, student_id: student, absence: attributes
            }.not_to change(Absence, :count)
          end

          it 'updates the requested absence' do
            put :update, day_id: day, student_id: student, absence: attributes
            absence.reload
            expect(absence.notes).to eq 'Good'
          end

          it "redirects to classroom's absence page" do
            put :update, day_id: day, student_id: student, absence: attributes
            expect(response).to redirect_to day_absences_url(day)
          end

          context 'with ajax' do
            it 'does not create a new absence' do
              expect {
                xhr :put, :update, day_id: day, student_id: student, absence: attributes
              }.not_to change(Absence, :count)
            end

            it 'updates the requested absence' do
              xhr :put, :update, day_id: day, student_id: student, absence: attributes
              absence.reload
              expect(absence.notes).to eq 'Good'
            end

            it "does not redirect to classroom's absence page" do
              xhr :put, :update, day_id: day, student_id: student, absence: attributes
              expect(response).not_to redirect_to day_absences_url(day)
            end
          end
        end

        context 'absence is not present' do
          it 'creates a new absence' do
            expect {
              put :update, day_id: day, student_id: student, absence: attributes
            }.to change(Absence, :count).by(1)
            expect(Absence.last.notes).to eq 'Good'
          end

          it "redirects to classroom's absence page" do
            put :update, day_id: day, student_id: student, absence: attributes
            expect(response).to redirect_to day_absences_url(day)
          end

          context 'with ajax' do
            it 'creates a new absence' do
              expect {
                xhr :put, :update, day_id: day, student_id: student, absence: attributes
              }.to change(Absence, :count).by(1)
              expect(Absence.last.notes).to eq 'Good'
            end

            it "does not redirect to classroom's absence page" do
              xhr :put, :update, day_id: day, student_id: student, absence: attributes
              expect(response).not_to redirect_to day_absences_url(day)
            end
          end
        end
      end

      describe 'DELETE #destroy' do
        it 'deletes the requested absence' do
          delete :destroy, id: absence
          expect(Absence.exists? absence.id).to be false
        end

        it "redirects to classroom's absences page" do
          delete :destroy, id: absence
          expect(response).to redirect_to day_absences_url(day)
        end

        context 'via ajax' do
          it 'deletes the requested absence' do
            xhr :delete, :destroy, id: absence
            expect(Absence.exists? absence.id).to be false
          end

          it 'succeed' do
            xhr :delete, :destroy, id: absence
            expect(response).to have_http_status :success
          end
        end
      end
    end
  end
end
