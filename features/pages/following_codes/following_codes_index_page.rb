class FollowingCodesIndexPage
  extend Capybara::DSL

  def self.visit_page_for_student student
    StudentPage.visit_page student
    click_on 'Following codes'
    self
  end
end
