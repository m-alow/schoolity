class SchoolsIndexPage
  include Capybara::DSL

  def visit_page
    visit '/schools'
    self
  end
end
