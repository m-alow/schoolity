class Timetable < ActiveRecord::Base
  belongs_to :classroom

  serialize :weekends, Array

  validates :classroom, :periods_number, presence: true
  validates :periods_number, numericality: { greater_than: 0, only_integer: true }
  validate  :weekends_must_be_array_of_days

  has_many :periods

  def build_periods params_list
    params_list.each do |params|
      periods.build day: params[:day],
                    order: params[:order],
                    subject: classroom.school_class.subjects.find_by(id: params[:subject_id])
    end
    self
  end

  def update_periods params_list
    params_list.each do |params|
      periods.
        find_by(day: params[:day], order: params[:order])&.
               update(subject: classroom.school_class.subjects.find_by(id: params[:subject_id]))
    end
    update(updated_at: Time.now)
    self
  end

  def study_days
    Date.current.all_week
      .reject { |day| weekend? day }
      .map { |day| day.strftime('%A') }
  end

  def periods_in date
    return [] if weekend?(date)
    periods.where(day: date.strftime('%A'))
  end

  def periods_hash
    study_days.map do |day|
      [day,
       periods.select { |period| period.day == day }.map do |period|
         [period.order, period]
       end.to_h]
    end.to_h
  end

  def current?
    active? && self == classroom.current_timetable
  end

  def weekend? date
    weekends.include? date.strftime('%A')
  end

  private

  def weekends_must_be_array_of_days
    days = ['Friday', 'Saturday', 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday']
    weekends.select { |day| !days.include? day }.each do |day|
      errors.add(:weekends, "has '#{day}' which is not a valid day name.")
    end
  end
end
