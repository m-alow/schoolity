require 'rails_helper'

RSpec.describe Day, type: :model do
  it 'has a valid factory' do
    expect(build(:day)).to be_valid
  end

  it { should belong_to :classroom }
  it { should have_many :lessons }

  it { should validate_presence_of :classroom }
  it { should validate_presence_of :date }
  it { should validate_presence_of :content_type }
  it { should_not validate_presence_of :content }

  it { should validate_uniqueness_of(:date).scoped_to(:classroom_id) }
end
