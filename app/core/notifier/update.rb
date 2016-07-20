class Notifier::Update
  attr_reader :scope, :notify

  def initialize scope
    @scope = scope
    @notify = Notifier::Notify
              .new(scope,
                   [Notifier::Publishers::Persist::Update.new,
                    Notifier::Publishers::Gcm::Create.new])
  end

  def call notifiable
    notify.call notifiable
  end
end
