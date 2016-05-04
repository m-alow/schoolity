require 'rails_helper'
require_relative '../capybara'

feature 'add school admin' do
  let(:owner) { create(:user) }
  let(:school) { create(:active_school, owner: owner) }
  let(:school_admin) { create(:user) }
  let(:form) { NewSchoolAdminForm }

  scenario 'owner can add admin to his school' do
    sign_in_user owner

    form.
      visit_page(school).
      fill_in_with(
        email: school_admin.email
      ).submit

    expect(page).to have_content 'successfully added'
    expect(page).to have_content school_admin.name

    SchoolAdminsIndexPage.visit_page(school)
    expect(page).to have_content school_admin.name
    expect(page).to have_content school_admin.email
  end

  scenario 'owner cannot add non existent admin to his school' do
    sign_in_user owner

    form.
      visit_page(school).
      fill_in_with(
        email: 'non-existent@mail.com'
      ).submit

    expect(page).not_to have_content 'successfully added'

    SchoolAdminsIndexPage.visit_page(school)
    expect(page).not_to have_content 'non-existent@mail.com'
  end
end
