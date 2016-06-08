require 'rails_helper'
require_relative '../capybara'

feature 'editing timetable' do
  let(:timetable) { create(:timetable, active: true, periods_number: 2, weekends: ['Friday', 'Saturday', 'Sunday', 'Tuesday', 'Wednesday', 'Thursday']) }
  let(:classroom) { timetable.classroom }
  let(:school_class) { classroom.school_class }
  let(:school_admin) { create(:school_administration, administrated_school: school_class.school).administrator }
  let!(:math) { create(:subject, school_class: school_class, name: 'Math') }
  let!(:physics) { create(:subject, school_class: school_class, name: 'Physics') }
  let!(:history) { create(:subject, school_class: school_class, name: 'History') }

  scenario 'by a school admin' do
    timetable.build_periods [
      { day: 'Monday', order: 1, subject_id: history.id },
      { day: 'Monday', order: 2, subject_id: history.id } ]
    timetable.save

    sign_in_user school_admin

    EditTimetableForm.
      visit_page(timetable).
      fill_in_with(
        active: false,
        periods: [
          { day: 'Monday', order: 1, subject: math },
          { day: 'Monday', order: 2, subject: physics },
        ]
      ).submit

    expect(page).to have_content 'successfully updated'
    expect(page).not_to have_content 'Current timetable.'
    expect(page).to have_content 'Math'
    expect(page).to have_content 'Physics'
    expect(page).not_to have_content 'History'
  end
end
