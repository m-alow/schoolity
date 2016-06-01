require 'rails_helper'

RSpec.describe Following, type: :model do
  it { should validate_presence_of :user }
  it { should validate_presence_of :student }
  it { should validate_presence_of :relationship }
  it { should validate_uniqueness_of(:student_id).scoped_to(:user_id) }
end
