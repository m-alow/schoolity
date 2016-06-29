class SchoolAnnouncementsIndexPage
  extend Capybara::DSL

  def self.visit_page school
    SchoolPage.visit_page school
    click_on 'Announcements list'
    self
  end
end
