class NewTimetableForm
  extend Capybara::DSL

  def self.visit_page classroom
    ClassroomPage.visit_page classroom
    click_on 'Create timetable'
    self
  end

  def self.fill_in_meta_data_with params = {}
    fill_in 'Periods number', with: params.fetch(:periods_number, 1)
    params[:weekends].each do |day|
      check day
    end
    self
  end

  def self.fill_in_with params = {}
    check 'timetable_active' if params[:active]
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
