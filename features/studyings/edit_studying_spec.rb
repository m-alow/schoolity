require 'rails_helper'
require_relative '../capybara'

feature 'edit studying' do
  let(:school) { create(:active_school) }
  let(:school_admin) { create(:school_administration, administrated_school: school).administrator }
  let(:classroom) { create(:classroom, school_class: create(:school_class, school: school)) }
  let(:student) { create(:student, school: school) }
  let(:studying) { create(:studying, student: student, classroom: classroom) }

  scenario 'school admin can edit' do
    sign_in_user school_admin

    EditStudyingForm.
      visit_page(studying).
      fill_in_with(
        beginning_date: Date.new(2015, 10, 10)
      ).submit

    expect(page).to have_content 'successfully updated'
  end

  scenario 'school admin cannot edit with invalid data' do
    sign_in_user school_admin

    EditStudyingForm.
      visit_page(studying).
      fill_in_with(
        beginning_date: nil
      ).submit

    expect(page).not_to have_content 'successfully updated'
  end
end
