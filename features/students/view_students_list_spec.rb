require 'rails_helper'
require_relative '../capybara'

feature 'view students listing' do
  let(:school) { create(:active_school) }
  let(:school_admin) { create(:school_administration, administrated_school: school).administrator }
  let(:school_class) { create(:school_class, school: school) }
  let(:classroom) { create(:classroom, school_class: school_class) }
  let(:student1) { build(:student) }
  let(:student2) { build(:student) }
  let(:other_school) { create(:active_school) }
  let(:outer_student) { build(:student) }
  let(:other_classroom) { create(:classroom, school_class: create(:school_class, school: other_school)) }

  background do
    school.students << student1
    school.students << student2
    other_school.students << outer_student
  end

  scenario 'in school' do
    sign_in_user school_admin

    StudentsIndexPage.visit_page_from_school(school)

    expect(page).to have_content student1.first_name
    expect(page).to have_content student2.first_name
    expect(page).not_to have_content outer_student.first_name
  end

  scenario 'in classroom' do
    sign_in_user school_admin
    student1.studyings << build(:studying, classroom: classroom)
    student2.studyings << build(:studying, classroom: other_classroom)

    StudentsIndexPage.visit_page_from_classroom(classroom)

    expect(page).to have_content student1.first_name
    expect(page).not_to have_content student2.first_name
    expect(page).not_to have_content outer_student.first_name
  end
end
