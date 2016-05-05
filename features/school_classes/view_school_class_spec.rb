require 'rails_helper'
require_relative '../capybara'

feature 'view school class' do
  let(:authorized_user) { create(:user) }
  let(:unauthorized_user) { create(:user) }
  let(:school) { create(:active_school) }
  let(:school_class) { create(:school_class, school: school) }

  background do
    school.administrators << authorized_user
  end

  scenario 'authorized user can view school class' do
    sign_in_user authorized_user

    SchoolClassPage.visit_page(school_class)

    expect(page).to have_content school_class.name
  end

  scenario 'unauthorized user cannot view school class' do
    sign_in_user unauthorized_user

    visit school_class_url(school_class)

    expect(page).to have_content 'not authorized'
    expect(page).not_to have_content school_class.name
  end
end
