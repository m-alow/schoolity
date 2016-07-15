require 'rails_helper'

RSpec.describe Absence, type: :model do
  it { should belong_to :student }
  it { should belong_to :day }
  it { should have_many :notifications }
  it { should have_many :comments }

  it { should validate_presence_of :student }
  it { should validate_presence_of :day }
  it { should_not validate_presence_of :notes }

  it 'has a valid factory' do
    expect(build(:absence)).to be_valid
  end
end
