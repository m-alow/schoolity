require 'rails_helper'

RSpec.describe ExamsController, type: :controller do
  let(:classroom) { create :classroom }
  let(:math) { create :subject, school_class: classroom.school_class, name: 'Math' }
  let(:exam) { create :exam, classroom: classroom, subject: math }
  let(:student) { create(:studying, classroom: classroom).student }

  let(:valid_attributes) { attributes_for(:exam).merge({ subject_id: math.id, grades_attributes: { '1' => { score: '5', student_id: student.id }} }) }
  let(:invalid_attributes) { attributes_for(:exam, score: -1).merge({ subject_id: math.id, grades_attributes: { '1' => { score: '5', student_id: student.id }} }) }

  context 'guest' do
    describe 'GET #index' do
      it 'requires login' do
        get :index, classroom_id: classroom
        expect(response).to require_login
      end
    end

    describe 'GET #show' do
      it 'requires login' do
        get :show, id: exam
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
        get :edit, id: exam
        expect(response).to require_login
      end
    end

    describe 'POST #create' do
      it 'requires login' do
        post :create, classroom_id: classroom, exam: valid_attributes
        expect(response).to require_login
      end
    end

    describe 'PUT #update' do
      it 'requires login' do
        put :update, id: exam, exam: valid_attributes
        expect(response).to require_login
      end
    end

    describe 'DELETE #destroy' do
      it 'requires login' do
        delete :destroy, id: exam
        expect(response).to require_login
      end
    end
  end

  context 'authenticated user' do

    context 'non authorized' do
      let(:user) { create :user }
      before { sign_in user }

      describe 'GET #index' do
        it 'requires authorization' do
          get :index, classroom_id: classroom
          expect(response).to require_authorization
        end
      end

      describe 'GET #show' do
        it 'requires authorization' do
          get :show, id: exam
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
          get :edit, id: exam
          expect(response).to require_authorization
        end
      end

      describe 'POST #create' do
        it 'requires authorization' do
          post :create, classroom_id: classroom, exam: valid_attributes
          expect(response).to require_authorization
        end
      end

      describe 'PUT #update' do
        it 'requires authorization' do
          put :update, id: exam, exam: valid_attributes
          expect(response).to require_authorization
        end
      end

      describe 'DELETE #destroy' do
        it 'requires authorization' do
          delete :destroy, id: exam
          expect(response).to require_authorization
        end
      end
    end

    context 'authorized' do
      let(:user) { create(:teaching, classroom: classroom, subject: math).teacher }
      before { sign_in user }

      describe 'GET #index' do
        it 'succeed' do
          get :index, classroom_id: classroom
          expect(response).to have_http_status :success
        end
      end

      describe 'GET #show' do
        it 'succeed' do
          get :show, id: exam
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
        it 'succeed' do
          get :edit, id: exam
          expect(response).to have_http_status :success
        end
      end

      describe 'POST #create' do
        context 'with valid params' do
          it 'creates a new Exam' do
            expect {
              post :create, classroom_id: classroom, exam: valid_attributes
            }.to change(Exam, :count).by(1)
          end

          it 'creates new Grades' do
            expect {
              post :create, classroom_id: classroom, exam: valid_attributes
            }.to change(Grade, :count).by(1)
          end

          it 'notifies followers about grades' do
            scope = double Scope::Student::Followers
            notifier = double CreateNotifier
            allow(Scope::Student::Followers).to receive(:new) { scope }
            allow(CreateNotifier).to receive(:new).with(scope) { notifier }

            expect(notifier).to receive :call
            post :create, classroom_id: classroom, exam: valid_attributes
          end

          it 'redirects to the created exam' do
            post :create, classroom_id: classroom, exam: valid_attributes
            expect(response).to redirect_to(Exam.last)
          end
        end

        context 'with invalid params' do
          it 'does not create a new Exam' do
            expect {
              post :create, classroom_id: classroom, exam: invalid_attributes
            }.not_to change(Exam, :count)
          end

          it "re-renders the 'new' template" do
            post :create, classroom_id: classroom, exam: invalid_attributes
            expect(response).to render_template('new')
          end
        end
      end

      describe 'PUT #update' do
        context 'with valid params' do
          let(:new_attributes) { attributes_for(:exam, score: 20).merge({ subject_id: math.id , grades_attributes: {} }) }

          it 'updates the requested exam' do
            put :update, id: exam, exam: new_attributes
            exam.reload
            expect(exam.score).to eq 20
          end

          it 'updates the requested grades' do
            grade = exam.grades.create!(score: 12, student: student)
            put :update, id: exam, exam: new_attributes.merge({ grades_attributes: { '1' => { score: 10, student_id: student.id } } })
            grade.reload
            expect(grade.score).to eq 10
          end

          it 'redirects to the exam' do
            put :update, id: exam, exam: new_attributes
            expect(response).to redirect_to(exam)
          end
        end

        context 'with invalid params' do
          it 'does not updates the requested exam' do
            put :update, id: exam, exam: invalid_attributes.merge({ score: 20, minimum_score: -2 , grades_attributes: {} })
            exam.reload
            expect(exam.score).not_to eq 20
          end

          it "re-renders the 'edit' template" do
            put :update, id: exam, exam: invalid_attributes.merge({ grades_attributes: {} })
            expect(response).to render_template('edit')
          end
        end
      end

      describe 'DELETE #destroy' do
        it 'destroys the requested exam' do
          delete :destroy, id: exam
          expect(Exam.exists? exam.id).to be false
        end

        it 'redirects to the exams list' do
          delete :destroy, id: exam
          expect(response).to redirect_to(classroom_exams_url(classroom))
        end
      end
    end
  end
end
