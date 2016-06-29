require 'rails_helper'
require_relative '../capybara'

feature 'viewing school announcements list' do
  let(:school) { create(:active_school) }
  let(:school_admin) { create(:school_administration, administrated_school: school).administrator }

  scenario 'school admin can view announcements' do
    sign_in_user school_admin

    a1 = create(:school_announcement, announceable: school)
    a2 = create(:school_announcement, announceable: school)
    a3 = create(:school_announcement, announceable: school)
    another_announcement = create(:school_announcement)

    SchoolAnnouncementsIndexPage.visit_page(school)

    expect(page).to have_content a1.title
    expect(page).to have_content a2.title
    expect(page).to have_content a3.title
    expect(page).not_to have_content another_announcement.title
  end
end
