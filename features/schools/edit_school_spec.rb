require 'rails_helper'
require_relative '../capybara'

feature 'edit school' do
  let(:owner) { create(:user) }
  let(:owner_school) { create(:school, active: true, owner: owner) }
  let(:other_school) { create(:school, active: true, owner: create(:user)) }
  let(:edit_school_form) { EditSchoolForm.new }

  scenario 'owner can edit school' do
    sign_in_user owner

    edit_school_form.
      visit_page(owner_school).
      fill_in_with(
        name: 'Edited School'
      ).submit

    expect(page).to have_content 'successfully updated'
    expect(page).to have_content 'Edited School'
  end

  scenario 'cannot edit other schools' do
    sign_in_user owner

    edit_school_form.
      visit_page(other_school)

    expect(page).to have_content 'not authorized'
  end

  scenario 'owner cannot edit school with invalid data' do
    sign_in_user owner

    edit_school_form.
      visit_page(owner_school).
      fill_in_with(
        name: ''
      ).submit

    expect(page).not_to have_content 'successfully updated'
  end

end
