require 'rails_helper'
require_relative '../capybara'

feature 'viewing a school announcement' do
  let(:school) { create(:active_school) }
  let(:school_admin) { create(:school_administration, administrated_school: school).administrator }

  scenario 'school admin can view an announcement' do
    sign_in_user school_admin

    a = create(:school_announcement, announceable: school)

    SchoolAnnouncementPage.visit_page a

    expect(page).to have_content a.title
    expect(page).to have_content a.body
  end
end
