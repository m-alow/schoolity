require 'rails_helper'
require_relative '../capybara'

feature 'add studying to student' do
  let(:school) { create(:active_school) }
  let(:school_admin) { create(:school_administration, administrated_school: school).administrator }
  let(:classroom) { create(:classroom, school_class: create(:school_class, school: school)) }
  let(:student) { create(:student, school: school) }

  background { classroom }

  scenario 'school admin can add' do
    sign_in_user school_admin

    NewStudyingForm.
      visit_page(student).
      fill_in_with(
        classroom: classroom.name,
        beginning_date: Date.new(2015, 1, 1)
      ).submit

    expect(page).to have_content 'successfully added'
    expect(page).to have_content classroom.name

    StudentPage.visit_studyings_page(student)

    expect(page).to have_content classroom.name
    expect(page).to have_content Date.new(2015, 1, 1).to_s
  end

  scenario 'school admin cannot add with invalid data' do
    sign_in_user school_admin

    NewStudyingForm.
      visit_page(student).
      fill_in_with(
        classroom: classroom.name,
        beginning_date: nil
      ).submit

    expect(page).not_to have_content 'successfully added'

    StudentPage.visit_studyings_page(student)

    expect(page).not_to have_content classroom.name
  end
end
