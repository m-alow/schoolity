require 'rails_helper'
require_relative '../capybara'

feature 'unfollowing a student' do
  scenario 'by a parent from the student page' do
    skip
    parent = create(:user)
    student = create(:following, user: parent).student

    sign_in_user parent

    FollowingsIndexPage.visit_page
    click_on 'Unfollow'

    expect(page).to have_content 'just unfollowed'

    FollowingsIndexPage.visit_page

    expect(page).not_to have_content student.name
  end

end
