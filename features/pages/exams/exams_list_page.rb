class ExamsListPage
  extend Capybara::DSL

  def self.visit_page classroom
    visit "/classrooms/#{classroom.id}/exams"
    self
  end

  def self.visit_as_teacher
    TeacherPanel.visit_page
    click_link 'Exams'
    self
  end
end
