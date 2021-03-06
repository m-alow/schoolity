require 'rails_helper'
require_relative '../capybara'

feature "view student's studyings list" do
  let(:school) { create(:active_school) }
  let(:school_admin) { create(:school_administration, administrated_school: school).administrator }
  let(:classroom) { create(:classroom, school_class: create(:school_class, school: school)) }
  let(:student) { create(:student, school: school) }
  let(:another_classroom) { create(:classroom, school_class: create(:school_class, school: school)) }
  let(:yet_another_classroom) { create(:classroom, school_class: create(:school_class, school: school)) }
  let(:another_student) { create(:student, school: school) }

  background do
    student.studyings.create(classroom: classroom, beginning_date: Date.today)
    student.studyings.create(classroom: another_classroom, beginning_date: 1.year.ago)
    another_student.studyings.create(classroom: classroom, beginning_date: Date.today)
    another_student.studyings.create(classroom: yet_another_classroom, beginning_date: Date.today)
  end

  scenario 'school admin views studyings for a student' do
    sign_in_user school_admin

    StudyingsIndexPage.visit_page(student)

    expect(page).to have_content student.name
    expect(page).not_to have_content another_student.name
    expect(page).to have_content classroom.name
    expect(page).to have_content another_classroom.name
    expect(page).not_to have_content yet_another_classroom.name
  end
end
