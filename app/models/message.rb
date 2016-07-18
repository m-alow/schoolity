class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :student

  validates :user, :student, :message_type, :content, presence: true
end
