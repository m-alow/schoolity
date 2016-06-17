class ExamsListPage
  extend Capybara::DSL

  def self.visit_page classroom
    visit "/classrooms/#{classroom.id}/exams"
    self
  end
end
