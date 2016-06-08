class StudentsIndexPage
  extend Capybara::DSL

  def self.visit_page_from_school(school)
    SchoolPage.visit_page(school)
    click_on 'Students list'
    self
  end

  def self.visit_page_from_classroom(classroom)
    ClassroomPage.visit_page(classroom)
    click_on 'Students'
    self
  end
end
