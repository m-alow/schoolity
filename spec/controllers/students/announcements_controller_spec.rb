require 'rails_helper'

RSpec.describe Students::AnnouncementsController, type: :controller do
  let(:announcement) { create(:student_announcement) }
  let(:student) { announcement.announceable }

  let(:valid_attributes) { attributes_for :student_announcement }
  let(:invalid_attributes) { attributes_for :student_announcement, title: nil }

  context 'guest' do
    describe 'GET #index' do
      it 'requires login' do
        get :index, student_id: student
        expect(response).to require_login
      end
    end

    describe 'GET #new' do
      it 'requires login' do
        get :new, student_id: student
        expect(response).to require_login
      end
    end

    describe 'POST #create' do
      it 'requires login' do
        post :create, student_id: student, announcement: valid_attributes
        expect(response).to require_login
      end
    end
  end

  context 'authenticated user' do
    context 'non authorized' do
      let(:user) { create(:user) }
      before { sign_in user }

      describe 'GET #index' do
        it 'requires authorization' do
          get :index, student_id: student
          expect(response).to require_authorization
        end
      end

      describe 'GET #new' do
        it 'requires authorization' do
          get :new, student_id: student
          expect(response).to require_authorization
        end
      end

      describe 'POST #create' do
        it 'requires authorization' do
          post :create, student_id: student, announcement: valid_attributes
          expect(response).to require_authorization
        end
      end
    end

    context 'authorized' do
      let(:user) { student.school.owner }
      before { sign_in user }

      describe 'GET #index' do
        it 'succeed' do
          get :index, student_id: student
          expect(response).to have_http_status :success
        end
      end

      describe 'GET #new' do
        it 'succeed' do
          get :new, student_id: student
          expect(response).to have_http_status :success
        end
      end

      describe 'POST #create' do
        context 'with valid params' do
          it 'creates a new Announcement' do
            expect {
              post :create, student_id: student, announcement: valid_attributes
            }.to change(Announcement, :count).by(1)
          end

          it 'sets the announceable to student' do
            post :create, student_id: student, announcement: valid_attributes
            expect(Announcement.last.announceable).to eq student
          end

          it 'sets the author to the signed in user' do
            post :create, student_id: student, announcement: valid_attributes
            expect(Announcement.last.author).to eq user
          end

          it 'redirects to the created announcement' do
            post :create, student_id: student, announcement: valid_attributes
            expect(response).to redirect_to(Announcement.last)
          end

          it 'notifies followers of students as follower' do
            notifier = double Notifier::Create
            scope = double Scope::Student::Followers
            allow(Scope::Student::Followers).to receive(:new).with(student) { scope }
            allow(Notifier::Create).to receive(:new).with(scope) { notifier }

            expect(notifier).to receive :call
            post :create, student_id: student, announcement: valid_attributes
          end
        end

        context 'with invalid params' do
          it 'does not create a new announcement' do
            expect {
              post :create, student_id: student, announcement: invalid_attributes
            }.not_to change(Announcement, :count)
          end

          it "re-renders the 'new' template" do
            post :create, student_id: student, announcement: invalid_attributes
            expect(response).to render_template('new')
          end
        end
      end
    end
  end
end
