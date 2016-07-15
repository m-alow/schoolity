class ClassroomAbsences
  def call day
    day.classroom.students.map do |s|
      s.absences.find_or_initialize_by day: day
    end
  end
end
