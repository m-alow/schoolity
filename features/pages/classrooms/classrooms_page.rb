class ClassroomPage
  extend Capybara::DSL

  def self.visit_page(classroom)
    ClassroomsIndexPage.visit_page(classroom.school_class)
    click_on classroom.name
    self
  end
end
