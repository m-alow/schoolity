require 'rails_helper'
require_relative '../capybara'

feature 'edit student' do
  let(:school) { create(:active_school) }
  let(:school_admin) { create(:school_administration, administrated_school: school).administrator }
  let(:student) { create(:student, school: school) }

  scenario 'school admin edits with valid data' do
    sign_in_user school_admin

    EditStudentForm.
      visit_page(student).
      fill_in_with(
        first_name: 'Mohammad'
      ).submit

    expect(page).to have_content ' successfully updated'
    expect(page).to have_content 'Mohammad'
  end

  scenario 'school admin cannot edit with invalid data' do
    sign_in_user school_admin

    EditStudentForm.
      visit_page(student).
      fill_in_with(
        first_name: ''
      ).submit

    expect(page).not_to have_content ' successfully updated'
  end
end
