class AgendasCalendarPage
  extend Capybara::DSL

  def self.visit_page classroom
    ClassroomPage.visit_page classroom
    click_on 'Agendas calendar'
    self
  end
end
