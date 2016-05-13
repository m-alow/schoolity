require 'rails_helper'
require_relative '../capybara'

feature "view studying" do
  let(:school) { create(:active_school) }
  let(:school_admin) { create(:school_administration, administrated_school: school).administrator }
  let(:classroom) { create(:classroom, school_class: create(:school_class, school: school)) }
  let(:another_classroom) { create(:classroom, school_class: create(:school_class, school: school)) }
  let(:student) { create(:student, school: school) }
  let(:studying) { create(:studying, student: student, classroom: classroom, beginning_date: Date.today) }
  let(:another_studying) { create(:studying, student: student, classroom: another_classroom, beginning_date: 1.year.ago) }

  background do
    Student
  end

  scenario 'school admin views studyings for a student' do
    sign_in_user school_admin

    StudyingPage.visit_page(studying)

    expect(page).to have_content classroom.name
    expect(page).not_to have_content another_classroom.name
  end
end
