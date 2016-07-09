require 'rails_helper'

RSpec.describe Behavior, type: :model do
  it { should belong_to :student }
  it { should belong_to :behaviorable }

  it { should validate_presence_of :student }
  it { should validate_presence_of :behaviorable }
  it { should validate_presence_of :content }
  it { should validate_presence_of :content_type }

  describe '.make' do
    let(:behavior) { Behavior.make notes: 'Good' }

    describe 'a new object' do
      it 'is a Behavior object' do
        expect(behavior.class).to be Behavior
      end

      it 'has basic content type' do
        expect(behavior.content_type).to eq 'basic'
      end

      it 'has content attributes' do
        expect(behavior.notes).to eq 'Good'
      end

      it 'is no persisted' do
        expect(behavior).not_to be_persisted
      end
    end
  end
end
