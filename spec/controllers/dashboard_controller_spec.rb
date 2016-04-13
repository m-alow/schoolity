require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  context 'guest access' do
    describe 'GET #index' do
      it 'requires login' do
        get :index
        expect(response).to require_login
      end
    end
  end

  context 'user access' do
    before(:each) do
      @user = create(:user)
      sign_in @user
    end

    describe 'GET #index' do
      it 'returns http success' do
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  end
end
