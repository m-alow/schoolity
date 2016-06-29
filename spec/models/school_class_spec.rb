require 'rails_helper'

RSpec.describe SchoolClass, type: :model do
  it 'has a valid factory' do
    expect(build(:school_class)).to be_valid
  end

  it 'is invalid without a name' do
    expect(build(:school_class, name: nil)).to be_invalid
  end

  it 'can not has a duplicate name in the same school' do
    school = create(:school)
    create(:school_class, school: school, name: 'A-1')
    duplicate_class = build(:school_class, school: school, name: 'A-1')
    expect(duplicate_class).to be_invalid
  end

  it 'can has a duplicate name across different schools' do
    school = create(:school)
    another_school = create(:school)
    create(:school_class, school: school, name: 'A-1')
    duplicate_class = build(:school_class, school: another_school, name: 'A-1')
    expect(duplicate_class).to be_valid
  end

  it { should have_many :subjects }
  it { should have_many :announcements }
end
