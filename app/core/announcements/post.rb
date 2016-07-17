module Announcements
  class Post < Rectify::Command
    attr_reader :announceable, :user, :post, :notify
    def initialize(announceable, user, attributes, notify)
      @announceable = announceable
      @user = user
      @post = "Announcements::Types::#{attributes[:type].camelcase}".constantize.new(attributes).call
      @notify = notify
    end

    def call
      announcement = build_announcement
      authorize announcement

      if announcement.save
        notify.(announcement)
        broadcast :success, announcement
      else
        broadcast :invalid, announcement
      end
    end

    private

    def build_announcement
      announceable.announcements.build(post).tap do |a|
        a.author = user
      end
    end

    def authorize announcement
      Pundit.authorize user, announcement, :create?
    end
  end
end
