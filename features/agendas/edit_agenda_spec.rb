require 'rails_helper'
require_relative '../capybara'

feature 'edit agenda' do
  let(:classroom) { create(:classroom) }
  let(:day) { Day.make_with_lessons(classroom: classroom, date: Date.current).tap { |d| d.save! } }
  let(:school_admin) { create(:school_administration, administrated_school: classroom.school).administrator }
  let(:timetable) { create(:timetable, classroom: classroom, active: true, periods_number: 2, weekends: []) }
  let(:math) { create(:subject, school_class: classroom.school_class, name: 'Math') }
  let(:physics) { create(:subject, school_class: classroom.school_class, name: 'Physics') }
  let(:teacher) { create(:teaching, subject: math, classroom: classroom).teacher }

  before do
    periods = timetable.study_days.map do |day|
      [ { day: day, subject_id: math.id, order: 1 }, { day: day, subject_id: physics.id, order: 2 } ]
    end.flatten

    timetable.build_periods periods
    timetable.save!
  end

  scenario 'school admin edits day summary' do
    sign_in_user school_admin

    EditAgendaForm
      .visit_page(day)
      .fill_in_with({ summary: 'It was a good day.' })
      .submit

    within '#day-summary' do
      expect(page).to have_content 'It was a good day.'
    end
  end

  scenario 'teacher edits lesson content' do
    sign_in_user teacher

    EditTeacherAgendaForm
      .visit_page(day)
      .fill_in_lesson_with(day.lessons.first, { title: 'Sum', summary: '1 + 1 = 6' })
      .submit_lesson(day.lessons.first)

    within "#classroom-#{classroom.id}-lesson-#{day.lessons.first.order}" do
      expect(page).to have_content 'Sum'
      expect(page).to have_content '1 + 1 = 6'
    end
  end
end
