class TimetableSerializer < ActiveModel::Serializer
  has_many :periods
  attributes :id, :classroom, :weekends, :periods_number, :periods

  def classroom
    {
      id: object.classroom.id,
      name: object.classroom.name,
      school_class: object.classroom.school_class.name,
      school: object.classroom.school.name
    }
  end

  def periods
    object.periods.sort_by { |p| [p.day.to_date.day, p.order] }
  end
end
