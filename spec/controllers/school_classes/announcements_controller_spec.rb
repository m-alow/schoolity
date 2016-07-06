require 'rails_helper'

RSpec.describe SchoolClasses::AnnouncementsController, type: :controller do
  let(:announcement) { create(:school_class_announcement) }
  let(:school_class) { announcement.announceable }

  let(:valid_attributes) { attributes_for :school_class_announcement }
  let(:invalid_attributes) { attributes_for :school_class_announcement, title: nil }

  context 'guest' do
    describe 'GET #index' do
      it 'requires login' do
        get :index, school_class_id: school_class
        expect(response).to require_login
      end
    end

    describe 'GET #new' do
      it 'requires login' do
        get :new, school_class_id: school_class
        expect(response).to require_login
      end
    end

    describe 'POST #create' do
      it 'requires login' do
        post :create, school_class_id: school_class, announcement: valid_attributes
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
          get :index, school_class_id: school_class
          expect(response).to require_authorization
        end
      end

      describe 'GET #new' do
        it 'requires authorization' do
          get :new, school_class_id: school_class
          expect(response).to require_authorization
        end
      end

      describe 'POST #create' do
        it 'requires authorization' do
          post :create, school_class_id: school_class, announcement: valid_attributes
          expect(response).to require_authorization
        end
      end
    end

    context 'authorized' do
      let(:user) { school_class.school.owner }
      before { sign_in user }

      describe 'GET #index' do
        it 'succeed' do
          get :index, school_class_id: school_class
          expect(response).to have_http_status :success
        end
      end

      describe 'GET #new' do
        it 'succeed' do
          get :new, school_class_id: school_class
          expect(response).to have_http_status :success
        end
      end

      describe 'POST #create' do
        context 'with valid params' do
          it 'creates a new Announcement' do
            expect {
              post :create, school_class_id: school_class, announcement: valid_attributes
            }.to change(Announcement, :count).by(1)
          end

          it 'sets the announceable to school_class' do
            post :create, school_class_id: school_class, announcement: valid_attributes
            expect(Announcement.last.announceable).to eq school_class
          end

          it 'sets the author to the signed in user' do
            post :create, school_class_id: school_class, announcement: valid_attributes
            expect(Announcement.last.author).to eq user
          end

          it 'notifies followers' do
            notifier = double Notifier::Create
            scope = double Scope::SchoolClass::Followers
            allow(Scope::SchoolClass::Followers).to receive(:new).with(school_class) { scope }
            allow(Notifier::Create).to receive(:new).with(scope) { notifier }

            expect(notifier).to receive(:call)
            post :create, school_class_id: school_class, announcement: valid_attributes
          end

          it 'redirects to the created announcement' do
            post :create, school_class_id: school_class, announcement: valid_attributes
            expect(response).to redirect_to(Announcement.last)
          end
        end

        context 'with invalid params' do
          it 'does not create a new announcement' do
            expect {
              post :create, school_class_id: school_class, announcement: invalid_attributes
            }.not_to change(Announcement, :count)
          end

          it "re-renders the 'new' template" do
            post :create, school_class_id: school_class, announcement: invalid_attributes
            expect(response).to render_template('new')
          end
        end
      end
    end
  end
end
