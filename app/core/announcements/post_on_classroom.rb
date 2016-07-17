module Announcements
  class PostOnClassroom < Rectify::Command
    def self.new classroom, user, attributes
      Announcements::Post.new(
        classroom,
        user,
        attributes,
        -> (announcement) { notify announcement, user }
      )
    end

    private

    def self.notify announcement, user
      Notifier::Create
        .new(Scope::Classroom::Followers.new(announcement.announceable))
        .call announcement

      Notifier::Create
        .new(Scope::Exclude.new(
              Scope::Classroom::Teachers.new(announcement.announceable),
              user))
        .call announcement
    end
  end
end
