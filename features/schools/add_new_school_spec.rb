require 'rails_helper'
require_relative '../capybara'

feature 'Add new school' do
  let(:user) { create(:user) }

  scenario 'user can add new school' do
    sign_in_user user

    NewSchoolForm.
      visit_page.
      fill_in_with(
        name: 'The school'
      ).submit

    expect(page).to have_content 'successfully created'
    expect(page).to have_content 'The school'
  end

  scenario 'user can not add new school with invalid information'  do
    sign_in_user user
    NewSchoolForm.
      visit_page.
      fill_in_with(
        name: ''
      ).submit

    expect(page).not_to have_content 'successfully created'
  end
end
