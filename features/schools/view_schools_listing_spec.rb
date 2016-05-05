require 'rails_helper'
require_relative '../capybara'

feature 'view schools listing' do
  let(:user) { create :user }
  let(:another_user) { create :user }

  scenario 'user sees all the activated schools' do
    school = create(:school, owner: user, active: true)
    another_school = create(:school, owner: another_user, active: true)

    sign_in_user user
    DashboardIndexPage.visit_schools_listing

    expect(page).to have_content school.name
    expect(page).to have_content another_school.name
  end

  scenario 'user does not see non-activated schools not owned by him' do
    school = create(:school, owner: user, active: true)
    another_non_activated_school = create(:school, owner: another_user)

    sign_in_user user
    DashboardIndexPage.visit_schools_listing

    expect(page).to have_content school.name
    expect(page).not_to have_content another_non_activated_school.name
  end
end
