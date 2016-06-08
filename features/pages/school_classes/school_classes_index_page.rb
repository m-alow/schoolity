class SchoolClassesIndexPage
  extend Capybara::DSL

  def self.visit_page(school)
    SchoolPage.visit_page(school)
    click_on 'Classes list'
    self
  end
end
