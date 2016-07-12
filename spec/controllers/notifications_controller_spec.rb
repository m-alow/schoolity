require 'rails_helper'

RSpec.describe NotificationsController, type: :controller do

  context 'guest' do
    let(:notification) { create :grade_notification, notifiable: create(:grade) }
    describe 'GET #show' do
      it 'require login' do
        get :show, id: notification
        expect(response).to require_login
      end
    end

    describe 'PUT #update' do
      it 'requires login' do
        put :update, id: notification
        expect(response).to require_login
      end
    end
  end

  context 'authenticated user' do

    context 'non authorized' do
      let(:notification) { create :grade_notification, notifiable: create(:grade) }
      before { sign_in create(:user) }

      describe 'GET #show' do
        it 'require authorization' do
          get :show, id: notification
          expect(response).to require_authorization
        end
      end

      describe 'PUT #update' do
        it 'requires authorization' do
          put :update, id: notification
          expect(response).to require_authorization
        end
      end
    end

    context 'authorized' do
      let(:user) { notification.recipient }
      before { sign_in user }

      context 'unread notification' do
        let!(:notification) { create :grade_notification, read_at: nil, notifiable: create(:grade) }

        describe 'GET #show' do
          it 'redirects to notifiable' do
            get :show, id: notification
            expect(response).to redirect_to notification.notifiable
          end

          it 'mark the notification as read' do
            get :show, id: notification
            notification.reload
            expect(notification).not_to be_nil
          end
        end

        describe 'PUT #update' do
          it 'redirects to notifiable' do
            put :update, id: notification
            expect(response).to redirect_to notification.notifiable
          end

          it 'mark the notification as read' do
            put :update, id: notification
            notification.reload
            expect(notification.read_at).not_to be_nil
          end

          context 'via ajax' do
            it 'succeed' do
              xhr :put, :update, id: notification
              expect(response).to have_http_status :success
            end

            it 'mark the notification as read' do
              xhr :put, :update, id: notification
              notification.reload
              expect(notification.read_at).not_to be_nil
            end
          end
        end
      end

      context 'read notification' do
        let!(:notification) { create(:grade_notification, read_at: '2010-10-10'.to_date, notifiable: create(:grade)) }

        describe 'GET #show' do
          it 'redirects to notifiable' do
            get :show, id: notification
            expect(response).to redirect_to notification.notifiable
          end

          it 'does not change the notification' do
            get :show, id: notification
            expect {
              notification.reload
            }.not_to change(notification, :read_at)
          end
        end

        describe 'PUT #update' do
          it 'redirects to notifiable' do
            put :update, id: notification
            expect(response).to redirect_to notification.notifiable
          end

          it 'mark the notification as unread' do
            put :update, id: notification
            notification.reload
            expect(notification.read_at).to be_nil
          end

          context 'via ajax' do
            it 'succeed' do
              xhr :put, :update, id: notification
              expect(response).to have_http_status :success
            end

            it 'mark the notification as read' do
              xhr :put, :update, id: notification
              notification.reload
              expect(notification.read_at).to be_nil
            end
          end
        end
      end
    end
  end
end
