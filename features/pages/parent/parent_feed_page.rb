class ParentFeedPage
  extend Capybara::DSL

  def self.visit_page
    ParentPanel.visit_page
    click_on 'Feed'
    self
  end
end
