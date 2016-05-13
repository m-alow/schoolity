class EditStudyingForm
  extend Capybara::DSL

  def self.visit_page(studying)
    StudyingPage.visit_page(studying)
    click_on 'Edit'
    self
  end

  def self.fill_in_with(params = {})
    select params[:classroom], from: 'Classroom' if params[:classroom]

    beginning_date = params.fetch(:beginning_date, Date.new(2010, 10, 10))
    if beginning_date
      select beginning_date.year , from: 'studying_beginning_date_1i'
      select beginning_date.strftime('%B') , from: 'studying_beginning_date_2i'
      select beginning_date.day , from: 'studying_beginning_date_3i'
    else
      select '', from: 'studying_beginning_date_1i'
    end

    end_date = params[:end_date]
    if end_date
      select end_date.year , from: 'studying_end_date_1i'
      select end_date.strftime('%B') , from: 'studying_end_date_2i'
      select end_date.day , from: 'studying_end_date_3i'
    else
      select '', from: 'studying_end_date_1i'
    end

    self
  end

  def self.submit
    click_on 'Submit'
  end
end
