class Activity < ActiveRecord::Base
  belongs_to :student
  belongs_to :lesson
  has_many :comments, as: :commentable

  serialize :content

  validates :student, :lesson, presence: true

  TYPE_TO_ROLE = {
    'base' => Roles::Activity::Base,
    'basic' => Roles::Activity::Basic
  }

  after_initialize do
    self.content_type ||= 'base'
    extend TYPE_TO_ROLE[content_type]
    initialize_content
  end

  def self.make student:, lesson:, **content_params
    new(student: student, lesson: lesson, content_type: 'basic').tap do |lesson|
      lesson.update_content content_params
    end
  end
end
