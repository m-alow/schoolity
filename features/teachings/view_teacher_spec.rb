require 'rails_helper'
require_relative '../capybara'

feature 'view teachers list' do
  let(:school) { create(:active_school) }
  let(:school_class) { create(:school_class, school: school) }
  let(:classroom) { create(:classroom, school_class: school_class) }
  let(:another_classroom) { create(:classroom, school_class: school_class) }
  let(:school_admin) { create(:school_administration, administrated_school: school).administrator }
  let(:subject) { create(:subject, school_class: school_class) }
  let!(:teacher) { create(:teaching, classroom: classroom, subject: subject).teacher }

  scenario 'school admin views teachers in a classroom' do
    sign_in_user school_admin

    TeacherPage.visit_page(teacher)

    expect(page).to have_content teacher.name
    expect(page).to have_content subject.name
    expect(page).to have_content classroom.name
  end
end
