class ExamPage
  extend Capybara::DSL

  def self.visit_as_teacher exam
    ExamsListPage.visit_as_teacher
    click_on exam.classroom.name
    click_on exam.subject.name
  end
end
