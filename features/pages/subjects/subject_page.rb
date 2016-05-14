class SubjectPage
  extend Capybara::DSL

  def self.visit_page(subject)
    SubjectsIndexPage.visit_page(subject.school_class)
    click_on subject.name
    self
  end
end
