class NewSchoolClassForm
  extend Capybara::DSL

  def self.visit_page(school)
    SchoolPage.visit_add_school_class(school)
    self
  end

  def self.fill_in_with(params)
    fill_in 'Name', with: params.fetch(:name, 'SC')
    self
  end

  def self.submit
    click_on 'Submit'
    self
  end
end
