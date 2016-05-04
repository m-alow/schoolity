class SchoolAdminsIndexPage
  extend Capybara::DSL

  def self.visit_page(school)
    SchoolPage.new.visit_school_admins_index(school)
    self
  end
end
