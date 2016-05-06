require 'rails_helper'
require_relative '../capybara'

feature 'edit classroom' do
  let(:school) { create(:active_school) }
  let(:school_admin) { create(:school_administration, administrated_school: school).administrator }
  let(:school_class) { create(:school_class, school: school) }
  let(:classroom) { create(:classroom, school_class: school_class) }

  scenario 'school admin edits classroom' do
    sign_in_user school_admin

    EditClassroomForm.
      visit_page(classroom).
      fill_in_with(
        name: 'C2'
      ).submit

    expect(page).to have_content 'successfully updated'
    expect(page).to have_content 'C2'
  end

  scenario 'school admin can not edits classroom with invalid data' do
    sign_in_user school_admin

    EditClassroomForm.
      visit_page(classroom).
      fill_in_with(
        name: ''
      ).submit

    expect(page).not_to have_content 'successfully updated'
    expect(page).not_to have_content 'C2'
  end
end
