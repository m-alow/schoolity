class EditTimetableForm
  extend Capybara::DSL

  def self.visit_page timetable
    TimetablePage.visit_page timetable
    click_on 'Edit'
    self
  end

  def self.fill_in_with params = {}
    if params[:active]
      check 'timetable_active'
    else
      uncheck 'timetable_active'
    end

    params[:periods].each do |period|
      select period[:subject].name, from: "#{period[:day]}_#{period[:order]}_period_subject_id"
    end
    self
  end

  def self.submit
    click_on 'Submit'
    self
  end
end
