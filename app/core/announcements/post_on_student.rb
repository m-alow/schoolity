module Announcements
  class PostOnStudent < Rectify::Command
    def self.new student, user, attributes
      Announcements::Post.new(
        student,
        user,
        attributes,
        -> (announcement) { notify announcement, user }
      )
    end

    private

    def self.notify announcement, user
      Notifier::Create
        .new(Scope::Student::Followers.new(announcement.announceable))
        .call announcement
    end
  end
end
