module Notifier
  class Create
    attr_reader :scope, :notify

    def initialize scope
      @scope = scope
      @notify = Notifier::Notify
                .new(scope,
                     [Notifier::Publishers::Persist::Create.new])
    end

    def call notifiable
      notify.call notifiable
    end
  end
end
