require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:comment) { create(:comment, commentable: create(:grade), body: 'no') }

  let(:valid_attributes) { { body: 'ok' } }
  let(:invalid_attributes) { { body: '' } }

  context 'guest' do
    describe 'DELETE #destroy' do
      it 'requires login' do
        delete :destroy, id: comment
        expect(response).to require_login
      end
    end

    describe 'PUT #update' do
      it 'requires login' do
        put :update, id: comment, comment: valid_attributes
        expect(response).to require_login
      end
    end
  end

  context 'authenticated user' do
    context 'non authorized' do
      before { sign_in create(:user) }
      describe 'DELETE #destroy' do
        it 'requires authorization' do
          delete :destroy, id: comment
          expect(response).to require_authorization
        end
      end

      describe 'PUT #update' do
        it 'requires authorization' do
          put :update, id: comment, comment: valid_attributes
          expect(response).to require_authorization
        end
      end
    end

    context 'authorized' do
      before { sign_in comment.user }

      describe 'DELETE #destroy' do
        it 'deletes the comment' do
          delete :destroy, id: comment
          expect(Comment.exists? comment.id).to be false
        end

        it 'redirects to the commentable' do
          delete :destroy, id: comment
          expect(response).to redirect_to comment.commentable
        end

        context 'via ajax' do
          it 'deletes the comment' do
            xhr :delete, :destroy, id: comment
            expect(Comment.exists? comment.id).to be false
          end

          it 'succeed' do
            xhr :delete, :destroy, id: comment
            expect(response).to have_http_status :success
          end
        end
      end

      describe 'PUT #update' do
        context 'with valid data' do
          it 'updates the comment' do
            put :update, id: comment, comment: valid_attributes
            comment.reload
            expect(comment.body).to eq 'ok'
          end

          it 'redirects to the commentable' do
            put :update, id: comment, comment: valid_attributes
            expect(response).to redirect_to comment.commentable
          end

          context 'via ajax' do
            it 'updates the comment' do
              xhr :put, :update, id: comment, comment: valid_attributes
              comment.reload
              expect(comment.body).to eq 'ok'
            end

            it 'succeed' do
              xhr :put, :update, id: comment, comment: valid_attributes
              expect(response).to have_http_status :success
            end
          end
        end
      end

      context 'with invalid data' do
        it 'does not update the comment' do
          put :update, id: comment, comment: invalid_attributes
          comment.reload
          expect(comment.body).to eq 'no'
        end

        it 'redirects to the commentable' do
          put :update, id: comment, comment: invalid_attributes
          expect(response).to redirect_to comment.commentable
        end

        context 'via ajax' do
          it 'updates the comment' do
            xhr :put, :update, id: comment, comment: invalid_attributes
            comment.reload
            expect(comment.body).to eq 'no'
          end

          it 'succeed' do
            xhr :put, :update, id: comment, comment: invalid_attributes
            expect(response).to have_http_status :success
          end
        end
      end
    end
  end
end
