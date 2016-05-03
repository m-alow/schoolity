require 'rails_helper'
require_relative '../capybara'

feature 'add school class' do
  let(:owner) { create(:user) }
  let(:owner_school) { create(:active_school, owner: owner) }
  let(:other_school) { create(:active_school) }
  let(:new_school_class_form) { NewSchoolClassForm.new }

  scenario 'owner can add school class to his school' do
    sign_in_user owner

    new_school_class_form.
      visit_page(owner_school).
      fill_in_with(
        name: '10'
      ).submit

    expect(page).to have_content 'successfully created'
    expect(page).to have_content '10'
  end

  scenario 'owner cannot add school class to other schools' do
    sign_in_user owner

    new_school_class_form.visit_page(other_school)

    expect(page).to have_content 'not authorized'
  end

  scenario 'owner cannot add school class with invalid data' do
    sign_in_user owner

    new_school_class_form.
      visit_page(owner_school).
      fill_in_with(
        name: ''
      ).submit

    expect(page).not_to have_content 'successfully created'
  end
end
