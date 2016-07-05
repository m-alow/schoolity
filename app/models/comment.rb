class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates :commentable, :user, :body, :role, presence: true

  scope :sorted, -> { order created_at: :desc }
end
