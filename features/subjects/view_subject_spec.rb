require 'rails_helper'
require_relative '../capybara'

feature 'view subject' do
  let(:school) { create(:active_school) }
  let(:school_class) { create(:school_class, school: school) }
  let(:school_admin) { create(:school_administration, administrated_school: school).administrator }
  let(:a_subject) { create(:subject, school_class: school_class) }

  scenario 'school admin views subject' do
    sign_in_user school_admin

    SubjectPage.visit_page(a_subject)

    expect(page).to have_content a_subject.name
    expect(page).to have_content a_subject.school_class.name
  end
end
