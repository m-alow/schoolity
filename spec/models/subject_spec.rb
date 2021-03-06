require 'rails_helper'

RSpec.describe Subject, type: :model do
  it 'has a valid factory' do
    expect(build(:subject)).to be_valid
  end

  it { should validate_presence_of :name }
  it { should validate_uniqueness_of(:name).scoped_to(:school_class_id) }
  it { should validate_presence_of :school_class }
  it { should_not validate_presence_of :description }
  it { should belong_to :school_class }
  it { should have_many :teachings }
  it { should have_many :exams }
end
