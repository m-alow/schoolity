require 'rails_helper'
require_relative '../capybara'

feature 'viewing timetables list for a classroom' do
  let(:classroom) { create(:classroom) }
  let(:school_admin) { create(:school_administration, administrated_school: classroom.school_class.school).administrator }

  scenario 'by a school admin' do
    sign_in_user school_admin

    create(:timetable, classroom: classroom, active: true)
    Timecop.travel Time.now + 1.year do
      create(:timetable, classroom: classroom, active: true)
    end

    Timecop.travel Time.now + 2.year do
      TimetablesIndexPage.visit_page classroom
    end

    expect(page).to have_content 'about 2 years'
    expect(page).to have_content 'about 1 year (current timetable)'
  end
end
