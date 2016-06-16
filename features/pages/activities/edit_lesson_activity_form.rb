class EditLessonActivityForm
  extend Capybara::DSL

  def self.visit_page lesson
    AgendaPage.visit_date_page lesson.day.classroom, lesson.day.date

    within "#lesson-#{lesson.order}" do
      click_on 'Edit Activities'
    end
    self
  end

  def self.select_student student
    click_on student.name
    self
  end

  def self.fill_in_with params = {}
    fill_in 'Notes', with: params[:notes]
    self
  end

  def self.submit
    click_on 'Submit'
    self
  end
end
