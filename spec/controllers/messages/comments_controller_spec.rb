require 'rails_helper'

RSpec.describe Messages::CommentsController, type: :controller do
  let(:message) { create :message }
  let(:school) { message.student.school }

  let(:valid_attributes) { attributes_for(:comment, commentable: message) }
  let(:invalid_attributes) { attributes_for(:comment, commentable: message, body: '') }

  context 'guest' do
    describe 'POST #create' do
      it 'requires login' do
        post :create, message_id: message, comment: valid_attributes
        expect(response).to require_login
      end
    end
  end

  context 'authenticated user' do
    context 'non authorized' do
      before { sign_in create(:user) }

      describe 'POST #create' do
        it 'requires authorization' do
          post :create, message_id: message, comment: valid_attributes
          expect(response).to require_authorization
        end
      end
    end

    context 'authorized' do
      let(:user) { school.owner }
      before { sign_in user }

      describe 'POST #create' do
        context 'with valid attributes' do
          it 'creates a new comment' do
            expect {
              post :create, message_id: message, comment: valid_attributes
            }.to change(Comment, :count).by(1)
          end

          it 'sets the signed in user as the comment author' do
            post :create, message_id: message, comment: valid_attributes
            expect(Comment.last.user).to eq user
          end

          it 'sets the commentable to message' do
            post :create, message_id: message, comment: valid_attributes
            expect(Comment.last.commentable).to eq message
          end

          xit 'notifies followers of students' do
          end

          it 'redirects to the message' do
            post :create, message_id: message, comment: valid_attributes
            expect(response).to redirect_to message
          end

          context 'via ajax' do
            it 'creates a new comment' do
              expect {
                xhr :post, :create, message_id: message, comment: valid_attributes
              }.to change(Comment, :count).by(1)
            end

            it 'sets the signed in user as the comment author' do
              xhr :post, :create, message_id: message, comment: valid_attributes
              expect(Comment.last.user).to eq user
            end

            it 'succeed' do
              xhr :post, :create, message_id: message, comment: valid_attributes
              expect(response).to have_http_status :success
            end
          end
        end

        context 'with invalid attributes' do
          it 'does not create a new comment' do
            expect {
              post :create, message_id: message, comment: invalid_attributes
            }.not_to change(Comment, :count)
          end

          it 'redirects to the message' do
            post :create, message_id: message, comment: valid_attributes
            expect(response).to redirect_to message
          end

          context 'via ajax' do
            it 'does not create a new comment' do
              expect {
                xhr :post, :create, message_id: message, comment: invalid_attributes
              }.not_to change(Comment, :count)
            end
          end
        end
      end
    end
  end
end
