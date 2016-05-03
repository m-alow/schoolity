require 'rails_helper'
require_relative '../capybara'

feature 'view school classes listing' do
  let(:owner) { create(:user) }
  let(:school) { create(:active_school, owner: owner) }
  let(:school_class) { @school_class }
  let(:second_school_class) { @second_school_class }
  let(:other_user) { create(:user) }
  let(:school_classes_index_page) { SchoolClassesIndexPage.new }

  background do
    @school_class = create(:school_class, school: school)
    @second_school_class = create(:school_class, school: school)
  end

  scenario 'owner sees all school classes in his school' do
    sign_in_user owner

    school_classes_index_page.visit_page(school)

    expect(page).to have_content school_class.name
    expect(page).to have_content second_school_class.name
  end

  scenario 'other users does not see school classes in some school' do
    sign_in_user other_user

    school_classes_index_page.visit_page(school)

    expect(page).to have_content 'not authorized'
    expect(page).not_to have_content school_class.name
    expect(page).not_to have_content second_school_class.name
  end
end
