class NewSchoolClassForm
  include Capybara::DSL

  def visit_page(school)
    SchoolPage.new.visit_add_school_class(school)
    self
  end

  def fill_in_with(params)
    fill_in 'Name', with: params.fetch(:name, 'SC')
    self
  end

  def submit
    click_on 'Submit'
    self
  end
end
