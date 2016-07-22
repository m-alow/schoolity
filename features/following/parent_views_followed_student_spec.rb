require 'rails_helper'
require_relative '../capybara'

feature 'viewing followed student' do
  scenario 'parent views' do
    skip
    parent = create(:user)
    student = create(:following, user: parent).student

    sign_in_user parent

    FollowingPage.visit_page student

    expect(page).to have_content student.name
  end
end
