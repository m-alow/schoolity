require 'rails_helper'
require_relative '../capybara'

feature 'viewing a school class announcement' do
  let(:school_class) { create(:school_class) }
  let(:school_admin) { create(:school_administration, administrated_school: school_class.school).administrator }

  scenario 'school admin can view an announcement' do
    sign_in_user school_admin

    a = create(:school_class_announcement, announceable: school_class)

    AnnouncementPage.visit_page_from_school_class a

    expect(page).to have_content a.title
    expect(page).to have_content a.body
  end
end
