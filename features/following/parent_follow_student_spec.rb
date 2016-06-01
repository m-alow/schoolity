require 'rails_helper'
require_relative '../capybara'

feature 'following a student' do
  let(:school) { create(:active_school) }
  let(:parent) { create(:user) }
  let(:student) { create(:student, school: school) }
  let(:following_code) { FollowingCode.make! student }

  scenario 'parent follows a student with a valid following code' do
    sign_in_user parent

    NewFollowingForm.
      visit_page.
      fill_in_with(
        following_code: following_code.code,
        student_full_name: student.full_name,
        relationship: 'Father').
      submit

    expect(page).to have_content 'successfully followed'
    expect(page).to have_content student.name
    expect(page).to have_content 'Father'
  end

  scenario 'parent cannot follow a student with an expired following code' do
    sign_in_user parent

    following_code

    Timecop.travel(Time.now + 100.hours) do
      puts 'shit' if  following_code.expired?
      NewFollowingForm.
        visit_page.
        fill_in_with(
          following_code: following_code.code,
          student_full_name: student.full_name,
          relationship: 'Father').
        submit

      expect(page).not_to have_content 'successfully followed'
    end
  end
end
