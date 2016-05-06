class ClassroomsIndexPage
  extend Capybara::DSL

  def self.visit_page(school_class)
    SchoolClassPage.visit_page school_class
    click_on 'Classrooms'
    self
  end
end
