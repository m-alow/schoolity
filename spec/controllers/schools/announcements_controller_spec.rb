require 'rails_helper'

RSpec.describe Schools::AnnouncementsController, type: :controller do
  let(:announcement) { create(:school_announcement) }
  let(:school) { announcement.announceable }

  let(:valid_attributes) { attributes_for :school_announcement }
  let(:invalid_attributes) { attributes_for :school_announcement, title: nil }

  context 'guest' do
    describe 'GET #index' do
      it 'requires login' do
        get :index, school_id: school
        expect(response).to require_login
      end
    end

    describe 'GET #show' do
      it 'requires login' do
        get :show, id: announcement
        expect(response).to require_login
      end
    end

    describe 'GET #new' do
      it 'requires login' do
        get :new, school_id: school
        expect(response).to require_login
      end
    end

    describe 'GET #edit' do
      it 'requires login' do
        get :edit, id: announcement
        expect(response).to require_login
      end
    end

    describe 'POST #create' do
      it 'requires login' do
        post :create, school_id: school, announcement: valid_attributes
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

      describe 'GET #index' do
        it 'requires authorization' do
          get :index, school_id: school
          expect(response).to require_authorization
        end
      end

      describe 'GET #show' do
        it 'requires authorization' do
          get :show, id: announcement
          expect(response).to require_authorization
        end
      end

      describe 'GET #new' do
        it 'requires authorization' do
          get :new, school_id: school
          expect(response).to require_authorization
        end
      end

      describe 'GET #edit' do
        it 'requires authorization' do
          get :edit, id: announcement
          expect(response).to require_authorization
        end
      end

      describe 'POST #create' do
        it 'requires authorization' do
          post :create, school_id: school, announcement: valid_attributes
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

      describe 'GET #index' do
        it 'succeed' do
          get :index, school_id: school
          expect(response).to have_http_status :success
        end
      end

      describe 'GET #show' do
        it 'succeed' do
          get :show, id: announcement
          expect(response).to have_http_status :success
        end
      end

      describe 'GET #new' do
        it 'succeed' do
          get :new, school_id: school
          expect(response).to have_http_status :success
        end
      end

      describe 'GET #edit' do
        it 'succeed' do
          get :edit, id: announcement
          expect(response).to have_http_status :success
        end
      end

      describe 'POST #create' do
        context 'with valid params' do
          it 'creates a new Announcement belongs to school' do
            expect {
              post :create, school_id: school, announcement: valid_attributes
            }.to change(Announcement, :count).by(1)

          end

          it 'sets the announceable to school' do
            post :create, school_id: school, announcement: valid_attributes
            expect(Announcement.last.announceable).to eq school
          end

          it 'sets the author to the signed in user' do
            post :create, school_id: school, announcement: valid_attributes
            expect(Announcement.last.author).to eq user
          end

          it 'redirects to the created announcement' do
            post :create, school_id: school, announcement: valid_attributes
            expect(response).to redirect_to(Announcement.last)
          end
        end

        context 'with invalid params' do
          it 'does not create a new announcement' do
            expect {
              post :create, school_id: school, announcement: invalid_attributes
            }.not_to change(Announcement, :count)
          end

          it "re-renders the 'new' template" do
            post :create, school_id: school, announcement: invalid_attributes
            expect(response).to render_template('new')
          end
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

        it 'redirects to the announcements list' do
          delete :destroy, id: announcement
          expect(response).to redirect_to(school_announcements_url(school))
        end
      end
    end
  end
end
