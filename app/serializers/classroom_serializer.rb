class ClassroomSerializer < ActiveModel::Serializer
  attributes :id, :name, :school_class, :school

  def school_class
    object.school_class.name
  end

  def school
    object.school.name
  end
end
