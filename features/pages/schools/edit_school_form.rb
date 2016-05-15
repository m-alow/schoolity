class EditSchoolForm
  extend Capybara::DSL

  def self.visit_page(school)
    SchoolPage.visit_page(school)
    click_on 'Edit'
    self
  end

  def self.fill_in_with(params = {})
    fill_in 'Name', with: params.fetch(:name, 'My School')
    self
  end

  def self.submit
    click_on 'Update School'
    self
  end
end
