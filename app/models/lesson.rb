class Lesson < ActiveRecord::Base
  belongs_to :day
  belongs_to :subject
  has_many :activities
  has_many :comments, as: :commentable

  serialize :content

  validates :day, :order, :content_type, presence: true
  validates :order, numericality: { only_integer: true }
  validates :order, uniqueness: { scope: :day_id }

  TYPE_TO_ROLE = {
    'base' => Roles::Lesson::Base,
    'basic' => Roles::Lesson::Basic
  }

  after_initialize do
    self.content_type ||= 'base'
    extend TYPE_TO_ROLE[content_type]
    initialize_content
  end

  def self.make day: nil, subject: nil, order:, **content_params
    new(day: day, subject: subject, order: order, content_type: 'basic').tap do |lesson|
      lesson.update_content content_params
    end
  end
end
