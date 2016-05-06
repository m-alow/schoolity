class EditClassroomForm
  extend Capybara::DSL

  def self.visit_page(classroom)
    ClassroomPage.visit_page(classroom)
    click_on 'Edit'
    self
  end

  def self.fill_in_with(params = {})
    fill_in 'Name', with: params.fetch(:name, 'CCC')
    self
  end

  def self.submit
    click_on 'Submit'
    self
  end
end
