require 'rails_helper'
require_relative '../capybara'

feature 'edit school announcement' do
  let(:school) { create(:active_school) }
  let(:school_admin) { create(:school_administration, administrated_school: school).administrator }
  let(:announcement) { create(:school_announcement, announceable: school, author: school_admin) }

  scenario 'school admin can edits announcement' do
    sign_in_user school_admin

    EditSchoolAnnouncementForm
      .visit_page(announcement)
      .fill_in_with(
        { id: announcement.id,
          title: 'New building.',
          body: 'The school building has moved.'})
      .submit

    expect(page).to have_content 'successfully updated'
    expect(page).to have_content 'New building.'
    expect(page).to have_content 'The school building has moved.'
  end

  scenario 'school admin cannot edit announcement with invalid data' do
    sign_in_user school_admin

    EditSchoolAnnouncementForm
      .visit_page(announcement)
      .fill_in_with(
        { id: announcement.id,
          title: '',
          body: 'The school building has moved.'})
      .submit

    expect(page).not_to have_content 'successfully updated'
    expect(page).not_to have_content 'New building.'
    expect(page).not_to have_content 'The school building has moved.'
    expect(page).to have_content "can't be blank"
  end
end
