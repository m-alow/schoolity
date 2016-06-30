require 'rails_helper'
require_relative '../capybara'

feature 'viewing classroom announcements list' do
  let(:classroom) { create(:classroom) }
  let(:school_admin) { create(:school_administration, administrated_school: classroom.school).administrator }

  scenario 'school admin can view announcements' do
    sign_in_user school_admin

    a1 = create(:classroom_announcement, announceable: classroom)
    a2 = create(:classroom_announcement, announceable: classroom)
    a3 = create(:classroom_announcement, announceable: classroom)
    another_announcement = create(:classroom_announcement)

    AnnouncementsIndexPage.visit_page_from_classroom(classroom)

    expect(page).to have_content a1.title
    expect(page).to have_content a2.title
    expect(page).to have_content a3.title
    expect(page).not_to have_content another_announcement.title
  end
end
