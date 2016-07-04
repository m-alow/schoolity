require 'rails_helper'
require_relative '../capybara'

feature 'parent views feed' do
  let(:student) { create(:studying).student }
  let(:parent) { create(:following, student: student).user }
  let(:classroom) { student.classroom }
  let(:school_class) { classroom.school_class }
  let(:school) { classroom.school }

  scenario 'viewing' do
    sign_in_user parent

    create(:classroom_announcement_notification,
           recipient: parent,
           notifiable: create(:classroom_announcement, announceable: classroom, title: 'Good News'))

    create(:school_class_announcement_notification,
           recipient: parent,
           notifiable: create(:school_class_announcement, announceable: school_class, title: 'Bad News'))

    create(:school_announcement_notification,
           recipient: parent,
           notifiable: create(:school_announcement, announceable: school, title: 'Just News'))

    create(:grade_notification,
           recipient: parent,
           notifiable: create(:grade, student: student, score: 25))

    ParentFeedPage.visit_page

    expect(page).to have_content 'Good News'
    expect(page).to have_content 'Bad News'
    expect(page).to have_content 'Just News'
    expect(page).to have_content '25.0 / 30'
  end
end
