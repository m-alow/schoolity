class TeacherClassrooms
  def call teacher
    Classroom.where(
      id: Teaching.select(:classroom_id).where(user_id: teacher.id))
  end
end
