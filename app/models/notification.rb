class Notification < ActiveRecord::Base
  belongs_to :notifiable, polymorphic: true
  belongs_to :recipient, class_name: 'User'

  validates :notifiable, :recipient, :recipient_role, presence: true

  scope :unread, -> { where(read_at: nil) }
  scope :sorted, -> { order(updated_at: :desc) }

  def read?
    read_at.present?
  end

  def mark_read!
    update_columns read_at: Time.zone.now
  end

  def mark_unread!
    update_columns read_at: nil
  end
end
