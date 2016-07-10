module Commenting
  class CommentOnBehavior < Rectify::Command
    def self.new(behavior, user, body)
      Commenting::Comment.new(
        commentable: behavior,
        user: user,
        body: body,
        role: -> (u) { user_role u, behavior },
        notify: -> (behavior) { notify_followers behavior, user }
      )
    end

    private

    def self.notify_followers behavior, user
      Notifier::Update
        .new(Scope::Exclude.new(
              Scope::Student::Followers.new(behavior.student), user))
        .call behavior
    end

    def self.user_role user, behavior
      send "#{behavior.behaviorable_type.underscore}_user_role", user, behavior
    end

    def self.lesson_user_role user, behavior
      classroom = behavior.behaviorable.day.classroom
      if user.owns? classroom.school
        'School Owner'
      elsif user.administrates? classroom.school
        'School Admin'
      elsif user.teaches_subject_in_classroom? behavior.behaviorable.subject, classroom
        'Teacher'
      elsif user.follows? behavior.student
        'Parent'
      end
    end

    def self.day_user_role user, behavior
      classroom = behavior.behaviorable.classroom
      if user.owns? classroom.school
        'School Owner'
      elsif user.administrates? classroom.school
        'School Admin'
      elsif user.follows? behavior.student
        'Parent'
      end
    end
  end
end
