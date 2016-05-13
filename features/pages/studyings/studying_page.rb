class StudyingPage
  extend Capybara::DSL

  def self.visit_page(studying)
    StudyingsIndexPage.visit_page(studying.student)
    click_on "studying-#{studying.id}"
    self
  end
end
