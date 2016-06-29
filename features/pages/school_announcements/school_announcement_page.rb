class SchoolAnnouncementPage
  extend Capybara::DSL

  def self.visit_page announcement
    SchoolAnnouncementsIndexPage.visit_page announcement.announceable
    click_on announcement.title
    self
  end
end
