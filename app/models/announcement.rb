class Announcement < ActiveRecord::Base
  belongs_to :announceable, polymorphic: true
  belongs_to :author, class_name: 'User'

  validates :announceable, :author, :title, :body, presence: true

  def for_school?
    announceable_type == 'School'
  end

  def for_school_class?
    announceable_type == 'SchoolClass'
  end

  def for_classroom?
    announceable_type == 'Classroom'
  end
end
