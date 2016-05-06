require 'rails_helper'
require_relative '../capybara'

feature 'view classroom page' do
  let(:school) { create(:active_school) }
  let(:school_admin) { create(:school_administration, administrated_school: school).administrator }
  let(:school_class) { create(:school_class, school: school) }
  let(:classroom) { create(:classroom, school_class: school_class) }

  scenario 'school administrator views classroom page' do
    sign_in_user school_admin

    ClassroomPage.visit_page(classroom)

    expect(page).to have_content classroom.name
  end
end
