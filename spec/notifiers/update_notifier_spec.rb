RSpec.describe UpdateNotifier do
  let(:scope) { double :scope }

  it 'publishes via Persist::Update' do
    publisher = double Notifier::Publishers::Persist::Update
    allow(Notifier::Publishers::Persist::Update).to receive(:new) { publisher }

    expect(Notify).to receive(:new).with(scope, [publisher])
    UpdateNotifier.new scope
  end

  it 'publishes the notifiable' do
    notifiable = double :notifiable
    notify = double Notify
    allow(Notify).to receive(:new) { notify }

    expect(notify).to receive(:call).with(notifiable)
    UpdateNotifier.new(scope).call notifiable
  end
end
