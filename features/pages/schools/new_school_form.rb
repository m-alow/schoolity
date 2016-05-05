class NewSchoolForm
  extend Capybara::DSL

  def self.visit_page
    DashboardIndexPage.visit_add_school
    self
  end

  def self.fill_in_with(params = {})
    fill_in 'Name', with: params.fetch(:name, 'School')
    self
  end

  def self.submit
    click_on 'Submit'
    self
  end
end
