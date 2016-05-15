class NewTeachingForm
  extend Capybara::DSL

  def self.visit_page(classroom)
    ClassroomPage.visit_page(classroom)
    click_on 'Add teacher'
    self
  end

  def self.fill_in_with(params = {})
    fill_in 'Email', with: params.fetch(:email, 'me@mail.com')
    select params.fetch(:subject, 'CS'), from: 'Subject'
    if params[:all_subjects]
      check 'All subjects'
    else
      uncheck 'All subjects'
    end
    self
  end

  def self.submit
    click_on 'Create Teaching'
    self
  end
end
