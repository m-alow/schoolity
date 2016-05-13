class StudentPage
  extend Capybara::DSL

  def self.visit_page(student)
    StudentsIndexPage.visit_page_from_school(student.school)
    click_on student.name
    self
  end

  def self.visit_studyings_page(student)
    visit_page(student)
    click_on 'Studyings'
  end

end
