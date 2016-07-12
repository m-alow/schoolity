class Behavior < ActiveRecord::Base
  belongs_to :student
  belongs_to :behaviorable, polymorphic: true
  has_many :comments, as: :commentable

  validates :student, :behaviorable, :content_type, presence: true

  serialize :content

  scope :sorted, -> { order(created_at: :desc) }

  after_initialize do
    self.content_type ||= 'base'
    extend "Roles::Behavior::#{content_type.camelcase}".constantize
    initialize_content
  end

  def self.make student: nil, behaviorable: nil, **content_params
    new(student: student, behaviorable: behaviorable, content_type: 'basic').tap do |b|
      b.update_content content_params
    end
  end
end
