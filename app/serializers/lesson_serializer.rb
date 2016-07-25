class LessonSerializer < ActiveModel::Serializer
  attributes :id, :subject, :order, :date, :content_type, :content, :activity, :behavior, :comments_count, :student, :classroom

  def activity
    ActiveModelSerializers::SerializableResource.new(object.activities.find_by student_id: student_id)
  end

  def behavior
    ActiveModelSerializers::SerializableResource.new(object.behaviors.find_by student_id: student_id)
  end

  def subject
    object.subject&.name
  end

  def date
    object.day.date
  end

  def student_id
    instance_options[:student_id]
  end

  def comments_count
    object.comments.count
  end

  def classroom
    ActiveModelSerializers::SerializableResource.new(object.day.classroom)
  end

  def student
    user_id = instance_options[:user_id]
    s = Student.find_by id: student_id
    s = Following.find_by(user: user_id, student: object.day.classroom.students)&.student if s.nil?

    ActiveModelSerializers::SerializableResource.new(s, user_id: user_id) if s.present?
  end
end
