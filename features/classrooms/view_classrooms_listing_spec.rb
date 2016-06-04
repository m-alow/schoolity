require 'rails_helper'
require_relative '../capybara'

feature 'view classrooms listing' do
  let(:school) { create(:active_school) }
  let(:school_admin) { create(:school_administration, administrated_school: school).administrator }
  let(:school_class) { create(:school_class, school: school) }
  let!(:classroom1) { create(:classroom, school_class: school_class) }
  let!(:classroom2) { create(:classroom, school_class: school_class) }
  let!(:outer_classroom) { create(:classroom) }

  scenario 'school admin views classrooms' do
    sign_in_user school_admin

    ClassroomsIndexPage.visit_page(school_class)

    expect(page).to have_content classroom1.name
    expect(page).to have_content classroom2.name
    expect(page).not_to have_content outer_classroom.name
  end
end
