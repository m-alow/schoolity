class AnnouncementSerializer < ActiveModel::Serializer
  attributes :id, :announceable_type, :announceable, :title, :body, :created_at

  def announceable
    send object.announceable_type.underscore
  end

  def classroom
    {
      id: object.announceable.id,
      name: object.announceable.name,
      school_class: object.announceable.school_class.name,
      school: object.announceable.school.name
    }
  end

  def student
    {
      id: object.announceable.id,
      name: object.announceable.name
    }
  end

  def school
    {
      id: object.announceable.id,
      name: object.announceable.name
    }
  end

  def school_class
    {
      id: object.announceable.id,
      name: object.announceable.name,
      school: object.announceable.school.name
    }
  end
end
