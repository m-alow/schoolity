class SchoolPage
  extend Capybara::DSL

  def self.visit_page(school)
    SchoolsIndexPage.visit_page
    click_on school.name
    self
  end

  def self.visit_add_school_class(school)
    visit_page(school)
    click_on 'Add class'
    self
  end

  def self.visit_add_school_admin(school)
    visit_page(school)
    click_on 'Add school admin'
    self
  end

  def self.visit_school_admins_index(school)
    visit_page(school)
    click_on 'School admins'
    self
  end
end
