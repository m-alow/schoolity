module Commenting
  class CommentOnAbsence < Rectify::Command
    def self.new(absence, user, body)
      Commenting::Comment.new(
        commentable: absence,
        user: user,
        body: body,
        role: -> (u) { user_role u, absence },
        notify: -> (absence) { notify absence, user }
      )
    end

    private

    def self.notify absence, user
      notify_followers absence, user
    end

    def self.notify_followers absence, user
      Notifier::Update
        .new(Scope::Exclude.new(
              Scope::Student::Followers.new(absence.student), user))
        .call absence
    end

    def self.user_role user, absence
      classroom = absence.day.classroom
      if user.owns? classroom.school
        'School Owner'
      elsif user.administrates? classroom.school
        'School Admin'
      elsif user.follows? absence.student
        'Parent'
      end
    end
  end
end
