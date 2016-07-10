class DaySerializer < ActiveModel::Serializer
  has_many :lessons
  attributes :date, :content_type, :content, :behavior, :classroom, :lessons

  def behavior
    ActiveModelSerializers::SerializableResource.new(object.behaviors.find_by student_id: student_id)
  end

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

  private

  def student_id
    instance_options[:student_id]
  end
end
