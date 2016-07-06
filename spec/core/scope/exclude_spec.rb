RSpec.describe Scope::Exclude do
  let(:subject) { Scope::Exclude }

  it 'has the same role of scope' do
    scope = double :scope, :role => 'Role'
    excluded = double :excluded
    expect(subject.new(scope, excluded).role).to eq 'Role'
  end

  describe '#.call' do
    let(:scope) { double :scope, :call => [1] }

    it 'does not excludes if excluded is empty' do
      expect(subject.new(scope, []).call).to eq [1]
    end

    it 'excludes if excluded is a single element' do
      expect(subject.new(scope, 1).call).to be_empty
    end

    it 'excludes if excluded is an array' do
      expect(subject.new(scope, [1]).call).to be_empty
    end

    it 'does not exclude element not in excluded' do
      expect(subject.new(scope, [2]).call).to eq [1]
    end

    it 'excludes repeated elements' do
      scope = double :scope, :call => [1, 2, 1]
      expect(subject.new(scope, [1]).call).to eq [2]
    end
  end
end
