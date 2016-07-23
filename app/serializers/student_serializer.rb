class StudentSerializer < ActiveModel::Serializer
  attributes :id, :name, :school, :school_class, :classroom, :following_id

  def name
    object.name
  end

  def school
    object.school.name
  end

  def school_class
    object.classroom&.school_class.name
  end

  def classroom
    object.classroom&.name
  end

  def following_id
    user_id = instance_options[:user_id]
    Following.find_by(user_id: user_id, student_id: object.id)&.id
  end
end
