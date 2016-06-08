require 'rails_helper'

RSpec.describe Period, type: :model do
  it { should belong_to :timetable }
  it { should belong_to :subject }

  it { should validate_presence_of :timetable }
  it { should validate_presence_of :day }
  it { should validate_presence_of :order }
  it { should_not validate_presence_of :subject }

  it { should validate_numericality_of(:order).only_integer.is_greater_than(0) }

  it { should validate_inclusion_of(:day).in_array(['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']) }

  it { should validate_uniqueness_of(:order).scoped_to([:timetable_id, :day]) }

end
