require 'rails_helper'
require_relative '../capybara'

feature 'add classroom announcement' do
  let(:classroom) { create(:classroom) }
  let(:school_admin) { create(:school_administration, administrated_school: classroom.school).administrator }

  scenario 'teacher can adds announcement' do
    sign_in_user school_admin

    NewAnnouncementForm
      .visit_page_from_classroom(classroom)
      .fill_in_with(
        { title: 'New building.',
          body: 'The school building has moved.'})
      .submit

    expect(page).to have_content 'successfully created'
    expect(page).to have_content 'New building.'
    expect(page).to have_content 'The school building has moved.'
  end

  scenario 'teacher cannot add announcement with invalid data' do
    sign_in_user school_admin

    NewAnnouncementForm
      .visit_page_from_classroom(classroom)
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
