require 'rails_helper'
require_relative '../capybara'

feature 'edit school class' do
  let(:user) { create(:user) }
  let(:school) { create(:active_school) }
  let(:school_class) { create(:school_class, school: school) }
  let(:form) { EditSchoolClassForm }

  background do
    school.administrators << user
  end

  scenario 'can edit school class' do
    sign_in_user user

    form.
      visit_page(school_class).
      fill_in_with(
        name: 'E12'
      ).submit

    expect(page).to have_content 'successfully updated'
    expect(page).to have_content 'E12'
  end

  scenario 'cannot edit school class with invalid data' do
    sign_in_user user

    form.
      visit_page(school_class).
      fill_in_with(
        name: ''
      ).submit


    expect(page).not_to have_content 'successfully updated'
    expect(page).not_to have_content 'E12'
  end
end
