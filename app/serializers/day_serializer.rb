class DaySerializer < ActiveModel::Serializer
  has_many :lessons
  attributes :date, :content_type, :content, :classroom, :lessons

  def classroom
    {
      id: object.classroom.id,
      name: object.classroom.name,
      school_class: object.classroom.school_class.name,
      school: object.classroom.school.name
    }
  end

  def lessons
    object.lessons.sort_by(&:order)
  end
end
