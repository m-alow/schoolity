class SchoolClassesIndexPage
  extend Capybara::DSL

  def self.visit_page(school)
    SchoolPage.visit_page(school)
    click_on 'School classes'
    self
  end
end
