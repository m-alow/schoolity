class SchoolClassesIndexPage
  include Capybara::DSL

  def visit_page(school)
    SchoolPage.new.visit_page(school)
    click_on 'School classes'
    self
  end
end
