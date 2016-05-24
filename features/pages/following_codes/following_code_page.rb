class FollowingCodePage
  extend Capybara::DSL

  def self.visit_page following_code
    FollowingCodesIndexPage.visit_page_for_student following_code.student
    click_on following_code.code
    self
  end
end
