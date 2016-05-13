class NewStudyingForm
  extend Capybara::DSL

  def self.visit_page(student)
    StudentPage.visit_page(student)
    click_on 'Add studying'
    self
  end

  def self.fill_in_with(params = {})
    select params.fetch(:classroom, 'C1'), from: 'Classroom'

    beginning_date = params.fetch(:beginning_date, Date.new(2010, 10, 10))
    if beginning_date
      select beginning_date.year , from: 'studying_beginning_date_1i'
      select beginning_date.strftime('%B') , from: 'studying_beginning_date_2i'
      select beginning_date.day , from: 'studying_beginning_date_3i'
    end
    self
  end

  def self.submit
    click_on 'Submit'
    self
  end
end
