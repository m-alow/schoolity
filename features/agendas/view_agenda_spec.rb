require 'rails_helper'
require_relative '../capybara'

feature 'viewing agenda' do
  let(:classroom) { create(:classroom) }
  let(:school_admin) { create(:school_administration, administrated_school: classroom.school).administrator }
  let(:timetable) { create(:timetable, classroom: classroom, active: true, periods_number: 2, weekends: []) }
  let(:math) { create(:subject, school_class: classroom.school_class, name: 'Math') }
  let(:physics) { create(:subject, school_class: classroom.school_class, name: 'Physics') }

  before do
    periods = timetable.study_days.map do |day|
      [ { day: day, subject_id: math.id, order: 1 }, { day: day, subject_id: physics.id, order: 2 } ]
    end.flatten

    timetable.build_periods periods
    timetable.save!
  end

  scenario 'school admin views agenda of today' do
    sign_in_user school_admin

    AgendaPage.visit_today_page classroom

    expect(page).to have_content math.name
    expect(page).to have_content physics.name
  end
end
