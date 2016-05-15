class EditTeachingForm
  extend Capybara::DSL

  def self.visit_page(teacher)
    TeacherPage.visit_page(teacher)
    click_on 'Edit'
    self
  end

  def self.fill_in_with(params = {})
    select params[:subject], from: 'Subject' if params[:subject]
    if params[:all_subjects]
      check 'All subjects'
    else
      uncheck 'All subjects'
    end
    self
  end

  def self.submit
    click_on 'Update Teaching'
    self
  end
end
