require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe 'GET #home' do
    context 'guest user' do
      it 'succeed' do
        get :home
        expect(response).to have_http_status :success
      end
    end

    context 'signed in user' do
      it 'redirects to dashboard' do
        sign_in create(:user)
        get :home
        expect(response).to redirect_to user_root_url
      end
    end
  end

  describe 'GET #about' do
    it 'succeed' do
      get :about
      expect(response).to have_http_status :success
    end
  end
end
