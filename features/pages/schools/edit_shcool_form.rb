class EditSchoolForm
  include Capybara::DSL

  def visit_page(school)
    visit "schools/#{school.id}/edit"
    self
  end

  def fill_in_with(params = {})
    fill_in 'Name', with: params.fetch(:name, 'My School')
    self
  end

  def submit
    click_on 'Submit'
    self
  end
end
