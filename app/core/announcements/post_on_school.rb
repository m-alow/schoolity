module Announcements
  class PostOnSchool < Rectify::Command
    def self.new school, user, attributes
      Announcements::Post.new(
        school,
        user,
        attributes,
        -> (announcement) { notify announcement, user }
      )
    end

    private

    def self.notify announcement, user
      Notifier::Create
        .new(Scope::School::Followers.new announcement.announceable)
        .call announcement
    end
  end
end
