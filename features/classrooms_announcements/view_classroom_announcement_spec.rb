require 'rails_helper'
require_relative '../capybara'

feature 'viewing a classroom announcement' do
  let(:classroom) { create(:classroom) }
  let(:school_admin) { create(:school_administration, administrated_school: classroom.school).administrator }

  scenario 'school admin can view an announcement' do
    sign_in_user school_admin

    a = create(:classroom_announcement, announceable: classroom)

    AnnouncementPage.visit_page_from_classroom a

    expect(page).to have_content a.title
    expect(page).to have_content a.body
  end
end
