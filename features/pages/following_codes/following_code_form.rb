class FollowingCodeForm
  extend Capybara::DSL

  def self.visit_page_for_student student
    StudentPage.visit_page student
    click_on 'Generate following code'
    self
  end

  def self.visit_page_for_classroom classroom
    ClassroomPage.visit_page classroom
    click_on 'Generate following codes'
    self
  end
end
