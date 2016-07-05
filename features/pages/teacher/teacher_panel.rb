class TeacherPanel
  extend Capybara::DSL

  def self.visit_page
    visit '/'
    click_on 'Teacher'
    self
  end
end
