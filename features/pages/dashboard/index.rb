class DashboardIndexPage
  include Capybara::DSL

  def visit_page
    visit '/'
    click_on 'Dashboard'
    self
  end

  def visit_schools_listing
    visit_page
    click_on 'Schools'
    self
  end

  def visit_add_school
    visit_page
    click_on 'Add school'
    self
  end
end
