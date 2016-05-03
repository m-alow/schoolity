class NewSchoolForm
  include Capybara::DSL

  def visit_page
    DashboardIndexPage.new.visit_add_school
    self
  end

  def fill_in_with(params = {})
    fill_in 'Name', with: params.fetch(:name, 'School')
    self
  end

  def submit
    click_on 'Submit'
    self
  end
end
