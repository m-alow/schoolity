require 'rails_helper'
require_relative '../capybara'

feature 'view following code' do
  let(:school) { create(:active_school) }
  let(:school_admin) { create(:school_administration, administrated_school: school).administrator }
  let(:school_class) { create(:school_class, school: school) }
  let(:classroom) { create(:classroom, school_class: school_class) }
  let(:student) { create(:student, school: school) }
  let(:following_code) { FollowingCode.make student }

  scenario 'school admin view following code for a student' do
    sign_in_user school_admin
    following_code.save!

    FollowingCodePage.visit_page(following_code)

    expect(page).to have_content student.name
    expect(page).to have_content following_code.code
  end
end
