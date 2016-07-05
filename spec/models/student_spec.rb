require 'rails_helper'

RSpec.describe Student, type: :model do
  it { should belong_to :school }
  it { should have_many :studyings }
  it { should have_many :following_codes }
  it { should have_many :activities }
  it { should have_many :grades }

  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :father_name }
  it { should validate_presence_of :birthdate }

  it { should validate_length_of(:first_name).is_at_least 2 }
  it { should validate_length_of(:last_name).is_at_least 2 }
  it { should validate_length_of(:father_name).is_at_least 2 }
  it { should validate_length_of(:mother_name).is_at_least(2) }


end
