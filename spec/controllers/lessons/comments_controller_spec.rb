require 'rails_helper'

RSpec.describe Lessons::CommentsController, type: :controller do
  let(:lesson) { create :lesson }

  let(:valid_attributes) { attributes_for(:comment, commentable: lesson) }
  let(:invalid_attributes) { attributes_for(:comment, commentable: lesson, body: '') }

  context 'guest' do
    describe 'POST #create' do
      it 'requires login' do
        post :create, lesson_id: lesson, comment: valid_attributes
        expect(response).to require_login
      end
    end
  end

  context 'authenticated user' do
    context 'non authorized' do
      before { sign_in create(:user) }

      describe 'POST #create' do
        it 'requires authorization' do
          post :create, lesson_id: lesson, comment: valid_attributes
          expect(response).to require_authorization
        end
      end
    end

    context 'authorized' do
      let(:user) { create(:teaching, classroom: lesson.day.classroom, all_subjects: true).teacher }
      before { sign_in user }

      describe 'POST #create' do
        context 'with valid attributes' do
          it 'creates a new comment' do
            expect {
              post :create, lesson_id: lesson, comment: valid_attributes
            }.to change(Comment, :count).by(1)
          end

          it 'sets the signed in user as the comment author' do
            post :create, lesson_id: lesson, comment: valid_attributes
            expect(Comment.last.user).to eq user
          end

          it 'sets the commentable to lesson' do
            post :create, lesson_id: lesson, comment: valid_attributes
            expect(Comment.last.commentable).to eq lesson
          end

          xit 'notifies followers of the student' do
          end

          it 'redirects to the lesson' do
            post :create, lesson_id: lesson, comment: valid_attributes
            expect(response).to redirect_to lesson
          end

          context 'via ajax' do
            it 'creates a new comment' do
              expect {
                xhr :post, :create, lesson_id: lesson, comment: valid_attributes
              }.to change(Comment, :count).by(1)
            end

            it 'sets the signed in user as the comment author' do
              xhr :post, :create, lesson_id: lesson, comment: valid_attributes
              expect(Comment.last.user).to eq user
            end

            it 'succeed' do
              xhr :post, :create, lesson_id: lesson, comment: valid_attributes
              expect(response).to have_http_status :success
            end
          end
        end

        context 'with invalid attributes' do
          it 'does not create a new comment' do
            expect {
              post :create, lesson_id: lesson, comment: invalid_attributes
            }.not_to change(Comment, :count)
          end

          it 'redirects to the lesson' do
            post :create, lesson_id: lesson, comment: valid_attributes
            expect(response).to redirect_to lesson
          end

          context 'via ajax' do
            it 'does not create a new comment' do
              expect {
                xhr :post, :create, lesson_id: lesson, comment: invalid_attributes
              }.not_to change(Comment, :count)
            end
          end
        end
      end
    end
  end
end
