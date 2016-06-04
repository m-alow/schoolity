require 'rails_helper'
require_relative '../capybara'

feature 'view school classes listing' do
  let(:owner) { create(:user) }
  let(:school) { create(:active_school, owner: owner) }
  let(:another_school) { create(:active_school) }
  let!(:school_class) { create(:school_class, school: school) }
  let!(:second_school_class) { create(:school_class, school: school) }
  let!(:another_school_class) { create(:school_class, school: another_school) }
  let(:other_user) { create(:user) }

  scenario 'owner sees all school classes in his school' do
    sign_in_user owner

    SchoolClassesIndexPage.visit_page(school)

    expect(page).to have_content school_class.name
    expect(page).to have_content second_school_class.name
    expect(page).not_to have_content another_school_class.name
  end

  scenario 'other users does not see school classes in some school' do
    sign_in_user other_user

    SchoolClassesIndexPage.visit_page(school)

    expect(page).to have_content 'not authorized'
    expect(page).not_to have_content school_class.name
    expect(page).not_to have_content second_school_class.name
  end
end
