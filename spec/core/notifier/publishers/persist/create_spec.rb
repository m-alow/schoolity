require 'rails_helper'

RSpec.describe Notifier::Publishers::Persist::Create do
  let(:subject) { Notifier::Publishers::Persist::Create.new }
  let(:notifiable) { create(:classroom_announcement) }

  it 'does not create new notifications in the database if there is no subscribers' do
    scope = double :scope, :call => []
    expect {
      subject.call scope, notifiable
    }.not_to change(Notification, :count)
  end

  it 'creates new notifications in the database if there are subscribers' do
    scope = double :scope, :call => [ create(:user), create(:user) ], :role => 'Role'
    expect {
      subject.call scope, notifiable
    }.to change(Notification, :count).by(2)
  end
end
