class EditTeacherAgendaForm
  extend Capybara::DSL

  def self.visit_page day
    visit "teacher/agendas/#{day.date}/edit"
    self
  end

  def self.fill_in_lesson_with lesson, params = {}
    within "#classroom-#{lesson.day.classroom.id}-lesson-#{lesson.order}-form" do
      fill_in 'Title', with: params[:title]
      fill_in 'Summary', with: params[:summary]
    end
    self
  end

  def self.submit_lesson lesson
    within "#classroom-#{lesson.day.classroom.id}-lesson-#{lesson.order}-form" do
      click_on 'Submit'
    end
    self
  end
end
