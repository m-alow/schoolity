class DayOnDate
  PresentDay = Struct.new(:status, :day)
  AbsentDay = Struct.new(:status)

  def call classroom, date
    day = classroom.day_at date
    return PresentDay.new(:study_day, day) if day.present?

    timetable = classroom.current_timetable
    if timetable.present?
      unless timetable.weekend? date
        day = Day.make_with_lessons(classroom: classroom, date: date)
        PresentDay.new(:study_day, day)
      else
        AbsentDay.new(:weekend)
      end
    else
      AbsentDay.new(:no_timetable)
    end
  end

  private
  attr_reader :classroom
end
