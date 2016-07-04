RSpec.describe CreateNotifier do
  let(:scope) { double :scope }

  it 'publishes via Persist::Create' do
    publisher = double Notifier::Publishers::Persist::Create
    allow(Notifier::Publishers::Persist::Create).to receive(:new) { publisher }

    expect(Notify).to receive(:new).with(scope, [publisher])
    CreateNotifier.new scope
  end

  it 'publishes the notifiable' do
    notifiable = double :notifiable
    notify = double Notify
    allow(Notify).to receive(:new) { notify }

    expect(notify).to receive(:call).with(notifiable)
    CreateNotifier.new(scope).call notifiable
  end
end
