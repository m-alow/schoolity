require 'rails_helper'
require_relative '../capybara'

feature 'view school' do
  let(:user) { create :user }


  scenario 'view active school' do
    sign_in_user user

    visit school_url(create(:active_school, name: 'My school'))

    expect(page).to have_content 'My school'
  end

  scenario 'cannot view non-active school' do
    sign_in_user user

    visit school_url(create(:non_active_school, name: 'My school'))

    expect(page).not_to have_content 'My school'
    expect(page).to have_content 'not authorized'
  end
end
