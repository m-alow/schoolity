RSpec.describe Notifier::Update do
  let(:scope) { double :scope }

  it 'publishes via Persist::Update' do
    publisher = double Notifier::Publishers::Persist::Update
    allow(Notifier::Publishers::Persist::Update).to receive(:new) { publisher }

    expect(Notifier::Notify).to receive(:new).with(scope, [publisher])
    Notifier::Update.new scope
  end

  it 'publishes the notifiable' do
    notifiable = double :notifiable
    notify = double Notifier::Notify
    allow(Notifier::Notify).to receive(:new) { notify }

    expect(notify).to receive(:call).with(notifiable)
    Notifier::Update.new(scope).call notifiable
  end
end
