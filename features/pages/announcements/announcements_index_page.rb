class AnnouncementsIndexPage
  extend Capybara::DSL

  def self.visit_page_from_school school
    SchoolPage.visit_page school
    click_on 'Announcements list'
    self
  end

  def self.visit_page_from_school_class school_class
    SchoolClassPage.visit_page school_class
    click_on 'Announcements list'
    self
  end

  def self.visit_page_from_classroom classroom
    ClassroomPage.visit_page classroom
    click_on 'Announcements list'
    self
  end
end
