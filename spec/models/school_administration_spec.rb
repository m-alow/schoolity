require 'rails_helper'

RSpec.describe SchoolAdministration, type: :model do
  it { should validate_presence_of :administrator }
  it { should validate_presence_of :administrated_school }
  it { should belong_to :administrator }
  it { should belong_to :administrated_school }
end
