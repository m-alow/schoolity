require 'rails_helper'

RSpec.describe Days::BehaviorsController, type: :controller do
  let(:classroom) { create(:classroom) }
  let(:student) { create(:studying, classroom: classroom).student }
  let(:date) { Date.current }
  let(:day) { Day.make(classroom: classroom, date: date).tap { |d| d.save! } }
  let(:behavior) { create(:behavior, student: student, behaviorable: day) }

  context 'guest' do
    describe 'GET #index' do
      it 'requires login' do
        get :index, day_id: day
        expect(response).to require_login
      end
    end

    describe 'GET #edit' do
      it 'requires login' do
        get :edit, day_id: day
        expect(response).to require_login
      end
    end

    describe 'PUT #upadte' do
      it 'requires login' do
        put :update, day_id: day, student_id: student
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

      describe 'GET #edit' do
        it 'requires authorization' do
          get :edit, day_id: day
          expect(response).to require_authorization
        end
      end

      describe 'PUT #upadte' do
        it 'requires authorization' do
          put :update, day_id: day, student_id: student
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

      describe 'GET #edit' do
        it 'succeed' do
          get :edit, day_id: day
          expect(response).to have_http_status :success
        end
      end

      describe 'PUT #upadte' do
        let(:attributes) { { notes: 'Good' } }

        context 'behavior is present' do
          let!(:behavior) { Behavior.make(student: student, behaviorable: day, notes: 'Bad.').tap { |b| b.save! } }

          it 'does not create a new behavior' do
            expect {
              put :update, day_id: day, student_id: student, behavior: attributes
            }.not_to change(Behavior, :count)
          end

          it 'updates the requested behavior' do
            put :update, day_id: day, student_id: student, behavior: attributes
            behavior.reload
            expect(behavior.notes).to eq 'Good'
          end

          it 'notifies followers of student' do
            scope = instance_double Scope::Student::Followers
            notifier= instance_double Notifier::Update
            allow(Scope::Student::Followers).to receive(:new).with(student) { scope }
            allow(Notifier::Update).to receive(:new).with(scope) { notifier }

            expect(notifier).to receive(:call)
            put :update, day_id: day, student_id: student, behavior: attributes
          end

          it "redirects to edit classroom's students form" do
            put :update, day_id: day, student_id: student, behavior: attributes
            expect(response).to redirect_to edit_day_behaviors_url(day)
          end

          context 'with ajax' do
            it 'does not create a new behavior' do
              expect {
                xhr :put, :update, day_id: day, student_id: student, behavior: attributes
              }.not_to change(Behavior, :count)
            end

            it 'updates the requested behavior' do
              xhr :put, :update, day_id: day, student_id: student, behavior: attributes
              behavior.reload
              expect(behavior.notes).to eq 'Good'
            end

            it 'notifies followers of student' do
              scope = instance_double Scope::Student::Followers
              notifier= instance_double Notifier::Update
              allow(Scope::Student::Followers).to receive(:new).with(student) { scope }
              allow(Notifier::Update).to receive(:new).with(scope) { notifier }

              expect(notifier).to receive(:call)
              xhr :put, :update, day_id: day, student_id: student, behavior: attributes
            end

            it "does not redirect to edit classroom's students form" do
              xhr :put, :update, day_id: day, student_id: student, behavior: attributes
              expect(response).not_to redirect_to edit_day_behaviors_url(day)
            end
          end
        end

        context 'behavior is not present' do
          it 'creates a new behavior' do
            expect {
              put :update, day_id: day, student_id: student, behavior: attributes
            }.to change(Behavior, :count).by(1)
            expect(Behavior.last.notes).to eq 'Good'
          end

          it 'notifies followers of student' do
            scope = instance_double Scope::Student::Followers
            notifier= instance_double Notifier::Update
            allow(Scope::Student::Followers).to receive(:new).with(student) { scope }
            allow(Notifier::Update).to receive(:new).with(scope) { notifier }

            expect(notifier).to receive(:call)
            put :update, day_id: day, student_id: student, behavior: attributes
          end

          it "redirects to edit classroom's students form" do
            put :update, day_id: day, student_id: student, behavior: attributes
            expect(response).to redirect_to edit_day_behaviors_url(day)
          end

          context 'with ajax' do
            it 'creates a new behavior' do
              expect {
                xhr :put, :update, day_id: day, student_id: student, behavior: attributes
              }.to change(Behavior, :count).by(1)
              expect(Behavior.last.notes).to eq 'Good'
            end

            it 'notifies followers of student' do
              scope = instance_double Scope::Student::Followers
              notifier= instance_double Notifier::Update
              allow(Scope::Student::Followers).to receive(:new).with(student) { scope }
              allow(Notifier::Update).to receive(:new).with(scope) { notifier }

              expect(notifier).to receive(:call)
              xhr :put, :update, day_id: day, student_id: student, behavior: attributes
            end

            it "does not redirect to edit classroom's students form" do
              xhr :put, :update, day_id: day, student_id: student, behavior: attributes
              expect(response).not_to redirect_to edit_day_behaviors_url(day)
            end
          end
        end
      end
    end
  end
end
