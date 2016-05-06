require 'rails_helper'
require_relative '../capybara'

feature 'add classroom' do
  let(:school) { create(:active_school) }
  let(:school_admin) { create(:school_administration, administrated_school: school).administrator }
  let(:school_class) { create(:school_class, school: school) }

  scenario 'school admin adds a classroom' do
    sign_in_user school_admin

    NewClassroomForm.
      visit_page(school_class).
      fill_in_with(
        name: 'A-10'
      ).submit

    expect(page).to have_content 'successfully added'
    expect(page).to have_content 'A-10'
  end

  scenario 'school admin cannot add a classroom with invalid data' do
    sign_in_user school_admin

    NewClassroomForm.
      visit_page(school_class).
      fill_in_with(
        name: ''
      ).submit

    expect(page).not_to have_content 'successfully added'
    expect(page).not_to have_content 'A-10'
  end
end
