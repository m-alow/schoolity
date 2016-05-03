class EditSchoolClassForm
  include Capybara::DSL

  def visit_page(school_class)
    SchoolClassPage.new.visit_page(school_class)
    click_on 'Edit'
    self
  end

  def fill_in_with(params = {})
    fill_in 'Name', with: params.fetch(:name, 'EEE')
    self
  end

  def submit
    click_on 'Submit'
    self
  end
end
