class Activity < ActiveRecord::Base
  belongs_to :student
  belongs_to :lesson
  has_many :comments, as: :commentable

  serialize :content

  validates :student, :lesson, presence: true

  scope :sorted, -> { order created_at: :desc }

  after_initialize do
    self.content_type ||= 'base'
    extend "Roles::Activity::#{content_type.camelcase}".constantize
    initialize_content
  end

  def self.make student:, lesson:, **content_params
    new(student: student, lesson: lesson, content_type: 'rated').tap do |lesson|
      lesson.update_content content_params
    end
  end
end
