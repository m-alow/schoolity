require 'rails_helper'
require_relative '../capybara'

feature 'view school admin' do
  let(:owner) { create(:user) }
  let(:school) { create(:school, owner: owner) }
  let(:admin) { create(:user) }

  scenario 'owner can view school admin page' do
    sign_in_user owner

    school.administrators << admin

    SchoolAdminsIndexPage.visit_page(school)
    click_on admin.name

    expect(page).to have_content admin.name
    expect(page).to have_content admin.email
  end
end
