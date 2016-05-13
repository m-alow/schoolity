class NewStudentForm
  extend Capybara::DSL

  def self.visit_page_from_classroom(classroom)
    ClassroomPage.visit_page(classroom)
    click_on 'Add student'
    self
  end

  def self.visit_page_from_school(school)
    SchoolPage.visit_page(school)
    click_on 'Add student'
    self
  end

  def self.fill_in_with(params = {})
    fill_in 'First name', with: params.fetch(:first_name, 'FFF')
    fill_in 'Last name', with: params.fetch(:last_name, 'LLL')
    fill_in 'Father name', with: params.fetch(:father_name, 'FAA')
    fill_in 'Mother name', with: params.fetch(:mother_name, 'MOO')
    birthdate = params.fetch(:birthdate, Date.today - 10.year)
    select birthdate.year , from: 'student_birthdate_1i'
    select birthdate.strftime('%B') , from: 'student_birthdate_2i'
    select birthdate.day , from: 'student_birthdate_3i'

    beginning_date = params[:beginning_date]
    if beginning_date
      select beginning_date.day, from: 'beginning_date_day'
      select beginning_date.strftime('%B'), from: 'beginning_date_month'
      select beginning_date.year, from: 'beginning_date_year'
    end
    self
  end

  def self.submit
    click_on 'Submit'
    self
  end
end
