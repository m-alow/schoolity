require 'rails_helper'
require_relative '../capybara'

feature 'viewing current timetable' do
  let(:timetable) { create(:timetable, active: true, periods_number: 2, weekends: ['Friday', 'Saturday', 'Sunday', 'Tuesday', 'Wednesday', 'Thursday']) }
  let(:classroom) { timetable.classroom }
  let(:school_class) { classroom.school_class }
  let(:school_admin) { create(:school_administration, administrated_school: school_class.school).administrator }
  let(:math) { create(:subject, school_class: school_class, name: 'Math') }
  let(:physics) { create(:subject, school_class: school_class, name: 'Physics') }

  scenario ' by school admin' do
    timetable.build_periods [
      { day: 'Monday', order: 1, subject_id: math.id },
      { day: 'Monday', order: 2, subject_id: physics.id } ]
    timetable.save

    sign_in_user school_admin

    ClassroomPage.visit_page classroom
    click_on 'Current timetable'

    expect(page).to have_content "Current timetable for #{classroom.name}"
    expect(page).to have_content 'Math'
    expect(page).to have_content 'Physics'
    expect(page).not_to have_content 'History'
    expect(page).to have_content 'Monday'
    expect(page).not_to have_content 'Friday'
  end

  scenario 'when there is no current one' do
    timetable.build_periods [
      { day: 'Monday', order: 1, subject_id: math.id },
      { day: 'Monday', order: 2, subject_id: physics.id } ]
    timetable.active = false
    timetable.save

    sign_in_user school_admin

    ClassroomPage.visit_page classroom
    click_on 'Current timetable'

    expect(page).to have_content 'There is no current timetable'
    expect(page).not_to have_content 'Math'
    expect(page).not_to have_content 'Physics'
    expect(page).not_to have_content 'History'
    expect(page).not_to have_content 'Monday'
  end
end
