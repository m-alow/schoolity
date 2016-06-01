class NewFollowingForm
  extend Capybara::DSL

  def self.visit_page
    DashboardIndexPage.visit_page
    click_on 'Follow a student'
    self
  end

  def self.fill_in_with(params = {})
    fill_in 'Student full name', with: params.fetch(:student_full_name, '')
    fill_in 'Following code', with: params.fetch(:following_code, '123')
    fill_in 'Relationship', with: params.fetch(:relationship, 'father')
    self
  end

  def self.submit
    click_on 'Follow'
    self
  end
end
