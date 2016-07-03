class ParentPanel
  extend Capybara::DSL

  def self.visit_page
    visit '/'
    click_on 'Parent'
    self
  end
end
