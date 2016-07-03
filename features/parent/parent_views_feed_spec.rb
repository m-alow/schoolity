require 'rails_helper'
require_relative '../capybara'

feature 'parent views feed' do
  let(:student) { create(:studying).student }
  let(:parent) { create(:following, student: student).user }
  let(:classroom) { student.classroom }

  scenario 'viewing' do
    sign_in_user parent

    create(:classroom_announcement_notification,
           recipient: parent,
           notifiable: create(:classroom_announcement, announceable: classroom, title: 'Good News'))

    create(:classroom_announcement_notification,
           recipient: parent,
           notifiable: create(:classroom_announcement, announceable: classroom, title: 'Bad News'))

    ParentFeedPage.visit_page

    expect(page).to have_content 'Good News'
    expect(page).to have_content 'Bad News'
  end
end
