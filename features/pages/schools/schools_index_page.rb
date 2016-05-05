class SchoolsIndexPage
  extend Capybara::DSL

  def self.visit_page
    visit '/schools'
    self
  end
end
