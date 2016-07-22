class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :student
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :user, :student, :message_type, presence: true

  serialize :content

  scope :sorted, -> { order created_at: :desc }
  scope :complaints, -> { where message_type: 'complaint' }

  after_initialize do
    self.content_type ||= 'base'
    extend "Roles::Message::#{content_type.camelcase}".constantize
    initialize_content
  end

  def self.make student: nil, user: nil, message_type: nil, content_type: 'basic', **content_params
    if message_type == 'absence_justification'
      content_type = 'absence'
    end
    new(student: student, user: user, message_type: message_type, content_type: content_type).tap do |b|
      b.update_content content_params
    end
  end
end
