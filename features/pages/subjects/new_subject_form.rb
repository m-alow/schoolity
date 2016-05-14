class NewSubjectForm
  extend Capybara::DSL

  def self.visit_page(school_class)
    SchoolClassPage.visit_page(school_class)
    click_on 'Add subject'
    self
  end

  def self.fill_in_with(params = {})
    fill_in 'Name', with: params.fetch(:name, 'CS')
    self
  end

  def self.submit
    click_on 'Create Subject'
    self
  end
end
