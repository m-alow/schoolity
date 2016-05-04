require 'rails_helper'
require_relative '../capybara'

feature 'view school admins listing' do
  let(:owner) { create(:user) }
  let(:school) { create(:active_school, owner: owner) }
  let(:admin1) { create(:user) }
  let(:admin2) {create(:user) }

  background do
    school.administrators << admin1 << admin2
  end

  scenario 'owner can see his school admins listing' do
    sign_in_user owner

    SchoolAdminsIndexPage.visit_page(school)

    expect(page).to have_content admin1.name
    expect(page).to have_content admin2.name

    expect(page).to have_content admin1.email
    expect(page).to have_content admin2.email
  end

  scenario 'other users does not see school admins listing' do
    sign_in_user create(:user)

    SchoolAdminsIndexPage.visit_page(school)

    expect(page).not_to have_content admin1.name
    expect(page).not_to have_content admin2.name

    expect(page).not_to have_content admin1.email
    expect(page).not_to have_content admin2.email

  end
end
