class DashboardIndexPage
  extend Capybara::DSL

  def self.visit_page
    visit '/'
    click_on 'Dashboard'
    self
  end

  def self.visit_schools_listing
    visit_page
    click_on 'Schools'
    self
  end

  def self.visit_add_school
    visit_page
    click_on 'Add school'
    self
  end
end
