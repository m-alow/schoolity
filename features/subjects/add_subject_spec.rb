require 'rails_helper'
require_relative '../capybara'

feature 'add subject to a school class' do
  let(:school) { create(:active_school) }
  let(:school_class) { create(:school_class, school: school) }
  let(:school_admin) { create(:school_administration, administrated_school: school).administrator }

  scenario 'school admin can add' do
    sign_in_user school_admin

    NewSubjectForm.
      visit_page(school_class).
      fill_in_with(
        name: 'Math'
      ).submit

    expect(page).to have_content 'successfully added'
    expect(page).to have_content 'Math'
  end

  scenario 'school admin cannot add with invalid data' do
    sign_in_user school_admin

    NewSubjectForm.
      visit_page(school_class).
      fill_in_with(
        name: ''
      ).submit

    expect(page).not_to have_content 'successfully added'
    expect(page).not_to have_content 'Math'
  end
end
