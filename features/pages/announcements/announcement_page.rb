class AnnouncementPage
  extend Capybara::DSL

  def self.visit_page_from_school announcement
    AnnouncementsIndexPage.visit_page_from_school announcement.announceable
    click_on announcement.title
    self
  end

  def self.visit_page_from_school_class announcement
    AnnouncementsIndexPage.visit_page_from_school_class announcement.announceable
    click_on announcement.title
    self
  end
end
