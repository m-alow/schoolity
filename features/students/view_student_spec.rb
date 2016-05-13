require 'rails_helper'
require_relative '../capybara'

feature 'view student' do
  let(:school) { create(:active_school) }
  let(:school_admin) { create(:school_administration, administrated_school: school).administrator }
  let(:school_class) { create(:school_class, school: school) }
  let(:classroom) { create(:classroom, school_class: school_class) }
  let(:student) { create(:student, school: school) }

  scenario 'school administrator views student' do
    sign_in_user school_admin

    StudentPage.visit_page(student)

    expect(page).to have_content student.first_name
  end
end
