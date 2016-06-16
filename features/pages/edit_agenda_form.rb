class EditAgendaForm
  extend Capybara::DSL

  def self.visit_page day
    visit "/classrooms/#{day.classroom.id}/agendas/#{day.date.to_param}/edit"
    self
  end

  def self.fill_in_with params = {}
    within '#day-summary-form' do
      fill_in 'Summary', with: params[:summary]
    end
    self
  end

  def self.fill_in_lesson_with lesson, params = {}
    within "#lesson-#{lesson.id}-form" do
      fill_in 'Title', with: params[:title]
      fill_in 'Summary', with: params[:summary]
    end
    self
  end

  def self.submit
    within '#day-summary-form' do
      click_on 'Submit'
    end
    self
  end

  def self.submit_lesson lesson
    within "#lesson-#{lesson.id}-form" do
      click_on 'Submit'
    end
    self
  end
end
