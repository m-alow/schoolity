class SchoolClassPage
  include Capybara::DSL

  def visit_page(school_class)
    SchoolClassesIndexPage.new.visit_page(school_class.school)
    click_on school_class.name
    self
  end
end
