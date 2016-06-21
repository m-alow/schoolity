require_relative 'on_date'

class PersistedDayOnDate
  def initialize classroom
    @classroom = classroom
  end

  def call date
    DayOnDate.new(@classroom).call(date).tap do |day_result|
      if day_result.status == :study_day && !day_result.day.persisted?
        day_result.day.save!
      end
    end
  end
end
