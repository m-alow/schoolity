class GradeSerializer < ActiveModel::Serializer
  attributes :id, :score, :exam, :student

  def exam
    ActiveModelSerializers::SerializableResource.new(object.exam)
  end

  def student
    object.student.name
  end
end
