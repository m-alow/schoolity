require 'rails_helper'
require_relative '../capybara'

feature 'viewing followed students list' do

  scenario 'parent can' do
    skip
    parent = create(:user)
    student = create(:following, user: parent).student
    another_student = create(:following).student

    sign_in_user parent
    FollowingsIndexPage.visit_page

    expect(page).to have_content student.name
    expect(page).not_to have_content another_student.name
  end
end
