class StudyingsIndexPage
  extend Capybara::DSL

  def self.visit_page(student)
    StudentPage.visit_page(student)
    click_on 'Studyings list'
    self
  end
end
