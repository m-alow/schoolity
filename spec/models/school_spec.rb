require 'rails_helper'

RSpec.describe School, type: :model do
  it 'has a valid factory' do
    expect(build(:school)).to be_valid
  end

  it 'is invalid without a name' do
    expect(build(:school, name: nil)).to be_invalid
  end

  it { should have_many :announcements }
end
