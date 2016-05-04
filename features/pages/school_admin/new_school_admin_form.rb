class NewSchoolAdminForm
  extend Capybara::DSL

  def self.visit_page(school)
    SchoolPage.new.visit_add_school_admin(school)
    self
  end

  def self.fill_in_with(params = {})
    fill_in 'Email', with: params.fetch(:email, 'me@mail.com')
    self
  end

  def self.submit
    click_on 'Submit'
    self
  end
end
