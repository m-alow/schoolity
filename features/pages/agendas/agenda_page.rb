class AgendaPage
  extend Capybara::DSL

  def self.visit_today_page classroom
    visit "/classrooms/#{classroom.id}/agendas/today"
    self
  end


  def self.visit_date_page classroom, date
    visit "/classrooms/#{classroom.id}/agendas/#{date.to_param}"
    self
  end

end
