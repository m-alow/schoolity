class TeacherPage
  extend Capybara::DSL

  def self.visit_page(teacher)
    TeachersIndexPage.visit_page(teacher.teachings.first.classroom)
    click_on teacher.name
    self
  end
end
