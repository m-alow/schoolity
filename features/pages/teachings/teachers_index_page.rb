class TeachersIndexPage
  extend Capybara::DSL

  def self.visit_page(classroom)
    ClassroomPage.visit_page(classroom)
    click_on 'Teachers list'
    self
  end
end
