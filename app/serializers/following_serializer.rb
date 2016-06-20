class FollowingSerializer < ActiveModel::Serializer
  attributes :id, :student, :relationship

  def student
    {
      id: object.student_id,
      name: object.student.name,
    }
  end
end
