require 'rails_helper'

RSpec.describe Lesson, type: :model do
  it 'has a valid factory' do
    expect(build(:lesson)).to be_valid
  end

  it { should belong_to :day }
  it { should belong_to :subject }

  it { should validate_presence_of :day }
  it { should_not validate_presence_of :subject }
  it { should validate_presence_of :order }
  it { should validate_presence_of :content_type }
  it { should_not validate_presence_of :content }

  it { should validate_numericality_of(:order).only_integer }

  it { should validate_uniqueness_of(:order).scoped_to(:day_id) }
end
