class EditSubjectForm
  extend Capybara::DSL

  def self.visit_page(subject)
    SubjectPage.visit_page(subject)
    click_on 'Edit'
    self
  end

  def self.fill_in_with(params = {})
    fill_in 'Name', with: params.fetch(:name, 'CS')
    self
  end

  def self.submit
    click_on 'Update Subject'
    self
  end
end
