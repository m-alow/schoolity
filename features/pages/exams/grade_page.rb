class GradePage
  extend Capybara::DSL

  def self.visit_as_teacher grade
    ExamPage.visit_as_teacher grade.exam
    click_on 'Discuss'
    self
  end

  def self.visit_as_parent grade
    ParentPanel.visit_page
    click_on 'Grades'
    click_on 'Discuss'
    self
  end
end
