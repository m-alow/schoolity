require 'rails_helper'

RSpec.describe Activities::CommentsController, type: :controller do
  let(:activity) { create :activity }

  let(:valid_attributes) { attributes_for(:comment, commentable: activity) }
  let(:invalid_attributes) { attributes_for(:comment, commentable: activity, body: '') }

  context 'guest' do
    describe 'POST #create' do
      it 'requires login' do
        post :create, activity_id: activity, comment: valid_attributes
        expect(response).to require_login
      end
    end
  end

  context 'authenticated user' do
    context 'non authorized' do
      before { sign_in create(:user) }

      describe 'POST #create' do
        it 'requires authorization' do
          post :create, activity_id: activity, comment: valid_attributes
          expect(response).to require_authorization
        end
      end
    end

    context 'authorized' do
      let(:user) { create(:following, student: activity.student).user }
      before { sign_in user }

      describe 'POST #create' do
        context 'with valid attributes' do
          it 'creates a new comment' do
            expect {
              post :create, activity_id: activity, comment: valid_attributes
            }.to change(Comment, :count).by(1)
          end

          it 'sets the signed in user as the comment author' do
            post :create, activity_id: activity, comment: valid_attributes
            expect(Comment.last.user).to eq user
          end

          it 'sets the commentable to activity' do
            post :create, activity_id: activity, comment: valid_attributes
            expect(Comment.last.commentable).to eq activity
          end

          it 'notifies followers of the student' do
            scope = double Scope::Student::Followers
            escope = double Scope::Exclude
            notifier = double Notifier::Create
            allow(Scope::Student::Followers).to receive(:new).with(activity.student) { scope }
            allow(Scope::Exclude).to receive(:new).with(scope, user) { escope }
            allow(Notifier::Update).to receive(:new).with(escope) { notifier }

            expect(notifier).to receive(:call)
            post :create, activity_id: activity, comment: valid_attributes
          end

          it 'redirects to the activity' do
            post :create, activity_id: activity, comment: valid_attributes
            expect(response).to redirect_to activity
          end

          context 'via ajax' do
            it 'creates a new comment' do
              expect {
                xhr :post, :create, activity_id: activity, comment: valid_attributes
              }.to change(Comment, :count).by(1)
            end

            it 'sets the signed in user as the comment author' do
              xhr :post, :create, activity_id: activity, comment: valid_attributes
              expect(Comment.last.user).to eq user
            end

            it 'succeed' do
              xhr :post, :create, activity_id: activity, comment: valid_attributes
              expect(response).to have_http_status :success
            end
          end
        end

        context 'with invalid attributes' do
          it 'does not create a new comment' do
            expect {
              post :create, activity_id: activity, comment: invalid_attributes
            }.not_to change(Comment, :count)
          end

          it 'redirects to the activity' do
            post :create, activity_id: activity, comment: valid_attributes
            expect(response).to redirect_to activity
          end

          context 'via ajax' do
            it 'does not create a new comment' do
              expect {
                xhr :post, :create, activity_id: activity, comment: invalid_attributes
              }.not_to change(Comment, :count)
            end
          end
        end
      end
    end
  end
end
