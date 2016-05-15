require 'rails_helper'

RSpec.describe Teaching, type: :model do
  it 'has a valid factory' do
    expect(build(:teaching)).to be_valid
  end

  it { should validate_presence_of :teacher }
  it { should validate_presence_of :classroom }

  it 'is invalid without subject and all_subjects is false' do
    expect(build(:teaching, subject: nil, all_subjects: false)).to be_invalid
  end

  it 'is valid with subject but all_subjects is false' do
    expect(build(:teaching, all_subjects: false)).to be_valid
  end

  it 'is valid without subject but all_subjects is true' do
    expect(build(:teaching, subject: nil, all_subjects: true)).to be_valid
  end

  it 'is valid with subject and all_subjects it true' do
    expect(build(:teaching, all_subjects: true)).to be_valid
  end

  it { should belong_to :teacher }
  it { should belong_to :classroom }
  it { should belong_to :subject }
end
