require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  it 'is invalid without a first name' do
    expect(build(:user, first_name: nil)).to be_invalid
  end

  it 'is invalid without a last name' do
    expect(build(:user, last_name: nil)).to be_invalid
  end

  it 'is invalid without an email' do
    expect(build(:user, email: nil)).to be_invalid
  end

  it 'returns the full name as a string' do
    user = build(:user, first_name: 'Mohammad', last_name: 'Alow')
    expect(user.name).to eq 'Mohammad Alow'
  end

  it { should have_many :teachings }
end
