class TimetablePage
  extend Capybara::DSL

  def self.visit_page timetable
    TimetablesIndexPage.visit_page timetable.classroom
    click_on "show-#{timetable.id}"
    self
  end
end
