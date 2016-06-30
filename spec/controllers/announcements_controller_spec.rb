require 'rails_helper'

RSpec.describe AnnouncementsController, type: :controller do
  let(:announcement) { create(:school_announcement) }
  let(:school) { announcement.announceable }

  let(:valid_attributes) { attributes_for :school_announcement }
  let(:invalid_attributes) { attributes_for :school_announcement, title: nil }

  context 'guest' do
    describe 'GET #show' do
      it 'requires login' do
        get :show, id: announcement
        expect(response).to require_login
      end
    end

    describe 'GET #edit' do
      it 'requires login' do
        get :edit, id: announcement
        expect(response).to require_login
      end
    end

    describe 'PUT #update' do
      it 'requires login' do
        put :update, id: announcement, announcement: valid_attributes
        expect(response).to require_login
      end
    end

    describe 'DELETE #destroy' do
      it 'requires login' do
        delete :destroy, id: announcement
        expect(response).to require_login
      end
    end
  end

  context 'authenticated user' do
    context 'non authorized' do
      let(:user) { create(:user) }
      before { sign_in user }

      describe 'GET #show' do
        it 'requires authorization' do
          get :show, id: announcement
          expect(response).to require_authorization
        end
      end

      describe 'GET #edit' do
        it 'requires authorization' do
          get :edit, id: announcement
          expect(response).to require_authorization
        end
      end

      describe 'PUT #update' do
        it 'requires authorization' do
          put :update, id: announcement, announcement: valid_attributes
          expect(response).to require_authorization
        end
      end

      describe 'DELETE #destroy' do
        it 'requires authorization' do
          delete :destroy, id: announcement
          expect(response).to require_authorization
        end
      end
    end

    context 'authorized' do
      let(:user) { school.owner }
      before do
        announcement.update(author: user)
        sign_in user
      end

      describe 'GET #show' do
        it 'succeed' do
          get :show, id: announcement
          expect(response).to have_http_status :success
        end
      end

      describe 'GET #edit' do
        it 'succeed' do
          get :edit, id: announcement
          expect(response).to have_http_status :success
        end
      end

      describe 'PUT #update' do
        context 'with valid params' do
          let(:new_attributes) { attributes_for(:announcement, title: 'new title') }

          it 'updates the requested announcement' do
            put :update, id: announcement, announcement: new_attributes
            announcement.reload
            expect(announcement.title).to eq 'new title'
          end

          it 'redirects to the announcement' do
            put :update, id: announcement, announcement: new_attributes
            expect(response).to redirect_to(announcement)
          end
        end

        context 'with invalid params' do
          let(:new_attributes) { attributes_for(:announcement, title: nil, body: 'new body') }

          it 'does not updates the requested announcement' do
            put :update, id: announcement, announcement: invalid_attributes
            announcement.reload
            expect(announcement.body).not_to eq 'new body'
          end

          it "re-renders the 'edit' template" do
            put :update, id: announcement, announcement: invalid_attributes
            expect(response).to render_template('edit')
          end
        end
      end

      describe 'DELETE #destroy' do
        it 'destroys the requested announcement' do
          delete :destroy, id: announcement
          expect(Announcement.exists?(announcement.id)).to be false
        end

        it 'redirects to the school announcements list if announceable is school' do
          delete :destroy, id: announcement
          expect(response).to redirect_to(school_announcements_url(school))
        end

        it 'redirects to the school class announcements list if announceable is school class' do
          announcement = create(:school_class_announcement, announceable: create(:school_class, school: school), author: user)
          delete :destroy, id: announcement
          expect(response).to redirect_to(school_class_announcements_url(announcement.announceable))
        end

        it 'redirects to the classroom announcements list if announceable is classroom' do
          classroom = create(:classroom, school_class: create(:school_class, school: school))
          announcement = create(:classroom_announcement, author: user, announceable: classroom)
          delete :destroy, id: announcement
          expect(response).to redirect_to(classroom_announcements_url(announcement.announceable))
        end
      end
    end
  end
end
