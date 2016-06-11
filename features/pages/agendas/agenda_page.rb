class AgendaPage
  extend Capybara::DSL

  def self.visit_today_page classroom
    visit "/classrooms/#{classroom.id}/agendas/today"
    self
  end
end
