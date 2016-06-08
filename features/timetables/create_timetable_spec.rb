require 'rails_helper'
require_relative '../capybara'

feature 'creating time table' do
  let(:school) { create(:active_school) }
  let(:school_class) { create(:school_class, school: school) }
  let(:classroom) { create(:classroom, school_class: school_class) }
  let!(:math) { create(:subject, school_class: school_class, name: 'Math') }
  let!(:physics) { create(:subject, school_class: school_class, name: 'Physics') }
  let!(:history) { create(:subject, school_class: school_class, name: 'History') }
  let(:school_admin) { create(:school_administration, administrated_school: school).administrator }

  scenario 'school admin can creates' do
    sign_in_user school_admin

    NewTimetableForm.
      visit_page(classroom).
      fill_in_meta_data_with(
        weekends: ['Friday', 'Sunday'],
        periods_number: 2
      ).submit.
      fill_in_with(
        active: true,
        periods: [
          { day: 'Tuesday', order: 1, subject: math },
          { day: 'Tuesday', order: 1, subject: math },
          { day: 'Monday', order: 1, subject: physics }
        ]
      ).submit

    expect(page).to have_content 'successfully created.'
    expect(page).to have_content math.name
    expect(page).to have_content physics.name
    expect(page).not_to have_content history.name
  end

  scenario 'school admin cannot creates with invalid data' do
    sign_in_user school_admin

    NewTimetableForm.
      visit_page(classroom).
      fill_in_meta_data_with(
        weekends: ['Friday', 'Sunday'],
        periods_number: 0
      ).submit

    expect(page).not_to have_content 'successfully created.'
    expect(page).to have_content 'greater than 0'
  end
end
