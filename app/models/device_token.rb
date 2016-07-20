class DeviceToken < ActiveRecord::Base
  belongs_to :user

  validates :user, :token, :role, presence: true
  validates :token, uniqueness: { scope: :user_id }
end
