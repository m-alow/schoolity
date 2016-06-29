require 'rails_helper'
require_relative '../capybara'

feature 'add class announcement' do
  let(:school_class) { create(:school_class) }
  let(:school_admin) { create(:school_administration, administrated_school: school_class.school).administrator }

  scenario 'school admin can adds announcement' do
    sign_in_user school_admin

    NewAnnouncementForm
      .visit_page_from_school_class(school_class)
      .fill_in_with(
        { title: 'New building.',
          body: 'The school building has moved.'})
      .submit

    expect(page).to have_content 'successfully created'
    expect(page).to have_content 'New building.'
    expect(page).to have_content 'The school building has moved.'
  end

  scenario 'school admin cannot add announcement with invalid data' do
    sign_in_user school_admin

    NewAnnouncementForm
      .visit_page_from_school_class(school_class)
      .fill_in_with(
        { title: '',
          body: 'The school building has moved.'})
      .submit

    expect(page).not_to have_content 'successfully created'
    expect(page).not_to have_content 'New building.'
    expect(page).not_to have_content 'The school building has moved.'
    expect(page).to have_content "can't be blank"
  end
end
