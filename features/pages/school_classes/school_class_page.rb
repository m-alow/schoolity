class SchoolClassPage
  extend Capybara::DSL

  def self.visit_page(school_class)
    SchoolClassesIndexPage.visit_page(school_class.school)
    click_on school_class.name
    self
  end
end
