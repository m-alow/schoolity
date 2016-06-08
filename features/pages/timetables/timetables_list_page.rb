class TimetablesIndexPage
  extend Capybara::DSL

  def self.visit_page classroom
    ClassroomPage.visit_page classroom
    click_on 'Timetables'
    self
  end
end
