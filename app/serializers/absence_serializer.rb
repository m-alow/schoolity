class AbsenceSerializer < ActiveModel::Serializer
  attributes :id, :student, :date, :notes, :comments_count

  def student
    object.student.name
  end

  def date
    object.day.date
  end

  def comments_count
    object.comments.count
  end
end
