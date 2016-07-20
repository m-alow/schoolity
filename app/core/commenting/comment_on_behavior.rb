module Commenting
  class CommentOnBehavior < Rectify::Command
    def self.new(behavior, user, body)
      Commenting::Comment.new(
        commentable: behavior,
        user: user,
        body: body,
        role: -> (u) { user_role u, behavior },
        notify: -> (behavior) { notify behavior, user }
      )
    end

    private

    def self.notify behavior, user
      notify_followers behavior, user
      notify_admins behavior, user
      notify_teachers behavior, user
    end

    def self.notify_followers behavior, user
      Notifier::Update
        .new(Scope::Exclude.new(
              Scope::Student::Followers.new(behavior.student), user))
        .call behavior
    end

    def self.notify_admins behavior, user
      Notifier::Update
        .new(Scope::Exclude.new(
              Scope::School::Admins.new(behavior.student.school), user))
        .call behavior
    end

    def self.notify_teachers behavior, user
      return unless behavior.behaviorable.is_a? Lesson
      lesson = behavior.behaviorable
      Notifier::Update
        .new(Scope::Exclude.new(
              Scope::Classroom::Subject::Teachers.new(lesson.day.classroom, lesson.subject), user))
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
