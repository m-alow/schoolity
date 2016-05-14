class SubjectsIndexPage
  extend Capybara::DSL

  def self.visit_page(school_class)
    SchoolClassPage.visit_page(school_class)
    click_on 'Subjects'
    self
  end
end
