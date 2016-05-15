class EditSchoolClassForm
  extend Capybara::DSL

  def self.visit_page(school_class)
    SchoolClassPage.visit_page(school_class)
    click_on 'Edit'
    self
  end

  def self.fill_in_with(params = {})
    fill_in 'Name', with: params.fetch(:name, 'EEE')
    self
  end

  def self.submit
    click_on 'Update School class'
    self
  end
end
