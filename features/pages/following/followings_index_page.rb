class FollowingsIndexPage
  extend Capybara::DSL

  def self.visit_page
    DashboardIndexPage.visit_page
    click_on 'Following'
    self
  end
end
