class SchoolPage
  include Capybara::DSL

  def visit_page(school)
    SchoolsIndexPage.new.visit_page
    click_on school.name
    self
  end

  def visit_add_school_class(school)
    visit_page(school)
    click_on 'Add school class'
    self
  end

  def visit_add_school_admin(school)
    visit_page(school)
    click_on 'Add school admin'
    self
  end

  def visit_school_admins_index(school)
    visit_page(school)
    click_on 'School admins'
    self
  end
end
