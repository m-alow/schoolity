require 'rails_helper'
require_relative '../capybara'

feature 'view following codes list' do
  let(:school) { create(:active_school) }
  let(:school_admin) { create(:school_administration, administrated_school: school).administrator }
  let(:school_class) { create(:school_class, school: school) }
  let(:classroom) { create(:classroom, school_class: school_class) }
  let(:student) { create(:student, school: school) }
  let(:another_student) { create(:student, school: school) }
  let(:student_in_another_classroom) { create(:student, school: school) }

  background do
    @student_code = FollowingCode.make! student
    @another_student_code = FollowingCode.make! another_student
    @another_classroom_code = FollowingCode.make! student_in_another_classroom
  end

  scenario 'school admin view following codes for a student' do
    sign_in_user school_admin

    FollowingCodesIndexPage.visit_page_for_student(student)

    expect(page).to have_content @student_code.code
    expect(page).not_to have_content @another_student_code.code
    expect(page).not_to have_content @another_classroom_code.code
  end


  scenario 'school admin view following codes for a students of a classroom' do
  end
end
