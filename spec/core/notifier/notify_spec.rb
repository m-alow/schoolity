RSpec.describe Notifier::Notify do
  let(:notifiable) { double :notifable }
  let(:scope) { double :scope }
  let(:p1) { double :publisher_1 }
  let(:p2) { double :publisher_2 }

  it 'does not notify if there is no publisher' do
    expect(p1).not_to receive(:call).with(scope, notifiable)
    expect(p2).not_to receive(:call).with(scope, notifiable)
    Notifier::Notify.new(scope, []).call notifiable
  end

  it 'notifies if there are publishers' do
    expect(p1).to receive(:call).with(scope, notifiable)
    expect(p2).to receive(:call).with(scope, notifiable)
    Notifier::Notify.new(scope, [p1, p2]).call notifiable
  end
end
