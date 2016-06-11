require 'rails_helper'
require_relative '../capybara'

feature 'viewing agenda calendar' do
  let(:classroom) { create(:classroom) }
  let(:school_admin) { create(:school_administration, administrated_school: classroom.school).administrator }

  scenario 'school admin views agenda of today' do
    sign_in_user school_admin

    AgendasCalendarPage.visit_page classroom

    expect(page).to have_link '1'
    expect(page).to have_link '5'
    expect(page).to have_link '10'
  end
end
