require 'rails_helper'

RSpec.describe Classroom, type: :model do
  it 'has a valid factory' do
    expect(build(:classroom)).to be_valid
  end

  it 'is invalid without a name' do
    expect(build(:classroom, name: nil)).to be_invalid
  end

  it 'can not have a duplicate name in the same school class' do
    school_class = create(:school_class)
    create(:classroom, school_class: school_class, name: '10')
    duplicate_classroom = build(:classroom, school_class: school_class, name: '10')
    expect(duplicate_classroom).to be_invalid
  end

  it 'can have a duplicate name in different school classes' do
    school_class = create(:school_class)
    other_school_class = create(:school_class)
    create(:classroom, school_class: school_class, name: '10')
    other_classroom = build(:classroom, school_class: other_school_class, name: '10')
    expect(other_classroom).to be_valid
  end
end
