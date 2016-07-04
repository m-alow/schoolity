require_dependency 'notifier/notify'
require_dependency 'notifier/publishers/persist/create'

class CreateNotifier
  attr_reader :scope, :notify

  def initialize scope
    @scope = scope
    @notify = Notify
              .new(scope,
                   [Notifier::Publishers::Persist::Create.new])
  end

  def call notifiable
    notify.call notifiable
  end
end
