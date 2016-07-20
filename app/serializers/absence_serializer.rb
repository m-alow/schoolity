class AbsenceSerializer < ActiveModel::Serializer
  attributes :id, :student, :date, :notes

  def student
    object.student.name
  end

  def date
    object.day.date
  end
end
