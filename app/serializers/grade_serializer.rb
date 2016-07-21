class GradeSerializer < ActiveModel::Serializer
  attributes :id, :score, :exam, :student, :comments_count

  def exam
    ActiveModelSerializers::SerializableResource.new(object.exam)
  end

  def student
    object.student.name
  end

  def comments_count
    object.comments.count
  end
end
