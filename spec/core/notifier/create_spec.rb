require 'rails_helper'

RSpec.describe Notifier::Create do
  let(:scope) { double :scope }

  xit 'publishes via Persist::Create' do
    publisher = double Notifier::Publishers::Persist::Create
    allow(Notifier::Publishers::Persist::Create).to receive(:new) { publisher }

    expect(Notifier::Notify).to receive(:new).with(scope, [publisher])
    Notifier::Create.new scope
  end

  it 'publishes the notifiable' do
    notifiable = double :notifiable
    notify = double Notifier::Notify
    allow(Notifier::Notify).to receive(:new) { notify }

    expect(notify).to receive(:call).with(notifiable)
    Notifier::Create.new(scope).call notifiable
  end
end
