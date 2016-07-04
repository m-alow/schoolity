require 'rails_helper'
require_relative '../capybara'

feature 'viewing timetables list for a classroom' do
  let(:classroom) { create(:classroom) }
  let(:school_admin) { create(:school_administration, administrated_school: classroom.school_class.school).administrator }

  scenario 'by a school admin' do
    sign_in_user school_admin

    create(:timetable, classroom: classroom, active: true)

    TimetablesIndexPage.visit_page classroom

    expect(page).to have_link 'Edit'
    expect(page).to have_link 'Show'
  end
end
