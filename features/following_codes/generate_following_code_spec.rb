require 'rails_helper'
require_relative '../capybara'

feature 'generate following code' do
  let(:school) { create(:active_school) }
  let(:school_admin) { create(:school_administration, administrated_school: school).administrator }
  let(:school_class) { create(:school_class, school: school) }
  let(:classroom) { create(:classroom, school_class: school_class) }
  let(:student) { create(:student, school: school) }
  let(:another_student) { create(:student, school: school) }
  let(:outer_student) { create(:student, school: school) }

  scenario 'school admin generates following code for a student' do
    sign_in_user school_admin

    FollowingCodeForm.visit_page_for_student(student)

    expect(page).to have_content 'successfully generated'
    expect(page).to have_content student.name
  end


  scenario 'school admin generates following codes for a students of a classroom' do
    classroom.studyings << build(:studying, student: student)
    classroom.studyings << build(:studying, student: another_student)

    sign_in_user school_admin

    FollowingCodeForm.visit_page_for_classroom classroom

    expect(page).to have_content 'successfully generated'
    expect(page).to have_content classroom.name
    expect(page).to have_content student.name
    expect(page).to have_content another_student.name
    expect(page).not_to have_content outer_student.name
  end
end
