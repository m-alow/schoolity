require 'rails_helper'

RSpec.describe Studying, type: :model do
  it { should validate_presence_of :classroom }
  it { should validate_presence_of :student }
  it { should validate_presence_of :beginning_date }
  it { should_not validate_presence_of :end_date }
end
