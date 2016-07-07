class ExamSerializer < ActiveModel::Serializer
  attributes :id, :date, :score, :minimum_score, :classroom, :subject

  def classroom
    {
      id: object.classroom.id,
      name: object.classroom.name,
      school_class: object.classroom.school_class.name,
      school: object.classroom.school.name
    }
  end

  def subject
    {
      name: object.subject.name
    }
  end
end
