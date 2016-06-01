class FollowingPage
  extend Capybara::DSL

  def self.visit_page student
    FollowingsIndexPage.visit_page
    click_on student.name
    self
  end
end
