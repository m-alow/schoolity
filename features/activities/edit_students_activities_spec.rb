require 'rails_helper'
require_relative '../capybara'

feature 'edit agenda' do
  let(:classroom) { create(:classroom) }
  let(:day) { Day.make_with_lessons(classroom: classroom, date: Date.current).tap { |d| d.save! } }
  let(:timetable) { create(:timetable, classroom: classroom, active: true, periods_number: 2, weekends: []) }
  let(:math) { create(:subject, school_class: classroom.school_class, name: 'Math') }
  let(:physics) { create(:subject, school_class: classroom.school_class, name: 'Physics') }
  let(:teacher) { create(:teaching, subject: math, classroom: classroom).teacher }
  let!(:student) { create(:studying, classroom: classroom).student }

  before do
    periods = timetable.study_days.map do |day|
      [ { day: day, subject_id: math.id, order: 1 }, { day: day, subject_id: physics.id, order: 2 } ]
    end.flatten

    timetable.build_periods periods
    timetable.save!
  end

  scenario "teacher edits student's activity" do
    sign_in_user teacher
    lesson = day.lessons.find_by(subject: math)

    EditLessonActivityForm
      .visit_page(lesson)
      .select_student(student)
      .fill_in_with({ notes: 'Good job.' })
      .submit

    expect(page).to have_content 'Good job.'
  end
end
