require 'rails_helper'
require_relative '../capybara'

feature 'viewing class announcements list' do
  let(:school_class) { create(:school_class) }
  let(:school_admin) { create(:school_administration, administrated_school: school_class.school).administrator }

  scenario 'school admin can view announcements' do
    sign_in_user school_admin

    a1 = create(:school_class_announcement, announceable: school_class)
    a2 = create(:school_class_announcement, announceable: school_class)
    a3 = create(:school_class_announcement, announceable: school_class)
    another_announcement = create(:school_class_announcement)

    AnnouncementsIndexPage.visit_page_from_school_class(school_class)

    expect(page).to have_content a1.title
    expect(page).to have_content a2.title
    expect(page).to have_content a3.title
    expect(page).not_to have_content another_announcement.title
  end
end
