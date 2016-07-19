class Day < ActiveRecord::Base
  belongs_to :classroom
  has_many :lessons, dependent: :delete_all
  has_many :behaviors, as: :behaviorable
  has_many :absences

  serialize :content

  validates :classroom, :content_type, :date, presence: true
  validates :date, uniqueness: { scope: :classroom_id }

  TYPE_TO_ROLE = {
    'base' => Roles::Day::Base,
    'basic' => Roles::Day::Basic
  }

  after_initialize do
    self.content_type ||= 'base'
    extend TYPE_TO_ROLE[content_type]
    initialize_content
  end

  def self.make classroom: nil, date:, **content_params
    new(classroom: classroom, date: date, content_type: 'basic').tap do |day|
      day.update_content content_params
    end
  end

  def self.make_with_lessons classroom:, date:, **day_params
    self.make(classroom: classroom, date: date, **day_params).tap do |day|
      day.lessons << classroom.current_timetable.periods_in(date).map do |period|
        Lesson.make(day: day, subject: period.subject, order: period.order)
      end
    end
  end
end
