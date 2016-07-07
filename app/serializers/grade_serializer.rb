class GradeSerializer < ActiveModel::Serializer
  attributes :id, :score, :exam

  def exam
    ActiveModelSerializers::SerializableResource.new(object.exam)
  end
end
