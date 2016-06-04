require 'rails_helper'
require_relative '../capybara'

feature 'view subjects list' do
  let(:school) { create(:active_school) }
  let(:school_class) { create(:school_class, school: school) }
  let(:school_admin) { create(:school_administration, administrated_school: school).administrator }
  let(:another_school_class) { create(:school_class, school: school) }
  let!(:subject1) { create(:subject, school_class: school_class) }
  let!(:subject2) { create(:subject, school_class: school_class) }
  let!(:another_subject) { create(:subject, school_class: another_school_class) }

  scenario 'school admin views subjects' do

    sign_in_user school_admin

    SubjectsIndexPage.visit_page(school_class)

    expect(page).to have_content subject1.name
    expect(page).to have_content subject2.name
    expect(page).not_to have_content another_subject.name
  end
end
