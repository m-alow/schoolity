require 'rails_helper'
require_relative '../capybara'

feature 'view teachers list' do
  let(:school) { create(:active_school) }
  let(:school_class) { create(:school_class, school: school) }
  let(:classroom) { create(:classroom, school_class: school_class) }
  let(:another_classroom) { create(:classroom, school_class: school_class) }
  let(:school_admin) { create(:school_administration, administrated_school: school).administrator }
  let(:teacher) { create(:user) }
  let!(:subject1) { create(:subject, school_class: school_class) }
  let!(:subject2) { create(:subject, school_class: school_class) }
  let!(:another_subject) { create(:subject, school_class: school_class) }
  let!(:teacher1) { create(:teaching, classroom: classroom, subject: subject1).teacher }
  let!(:teacher2) { create(:teaching, classroom: classroom, subject: subject2).teacher }
  let!(:another_teacher) { create(:teaching, classroom: another_classroom, subject: another_subject).teacher }

  scenario 'school admin views teachers in a classroom' do
    sign_in_user school_admin

    TeachersIndexPage.visit_page(classroom)

    expect(page).to have_content teacher1.name
    expect(page).to have_content teacher2.name
    expect(page).to have_content subject1.name
    expect(page).to have_content subject2.name
    expect(page).not_to have_content another_teacher.name
    expect(page).not_to have_content another_subject.name
  end
end
