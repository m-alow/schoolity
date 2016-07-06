require_dependency 'notifier/notify'
require_dependency 'notifier/publishers/persist/update'

class UpdateNotifier
  attr_reader :scope, :notify

  def initialize scope
    @scope = scope
    @notify = Notify
              .new(scope,
                   [Notifier::Publishers::Persist::Update.new])
  end

  def call notifiable
    notify.call notifiable
  end
end
