require 'day/on_date'

class TeacherLessons
  Result = Struct.new :classroom, :lessons

  def call teacher, date
    classrooms_of(teacher)
      .map { |c| DayOnDate.new.call(c, date) }
      .select { |d| d.status == :study_day }
      .map(&:day)
      .map { |d| Result.new d.classroom, lessons(d, teacher) }
      .reject { |r| r.lessons.empty? }
  end

  private

  def classrooms_of teacher
    Classroom.where(
      id: Teaching.select(:classroom_id).where(user_id: teacher.id))
  end

  def lessons day, teacher
    day.lessons.select do |l|
      teacher.teaches_subject_in_classroom? l.subject, day.classroom
    end
  end
end
