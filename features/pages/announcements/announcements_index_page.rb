class AnnouncementsIndexPage
  extend Capybara::DSL

  def self.visit_page_from_school school
    SchoolPage.visit_page school
    click_on 'Announcements list'
    self
  end
end
