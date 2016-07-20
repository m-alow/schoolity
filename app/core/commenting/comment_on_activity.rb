module Commenting
  class CommentOnActivity < Rectify::Command
    def self.new(activity, user, body)
      Commenting::Comment.new(
        commentable: activity,
        user: user,
        body: body,
        role: -> (u) { user_role u, activity },
        notify: -> (activity) { notify activity, user }
      )
    end

    private

    def self.notify activity, user
      notify_followers activity, user
      notify_teachers activity, user
    end

    def self.notify_followers activity, user
      Notifier::Update
        .new(Scope::Exclude.new(
              Scope::Student::Followers.new(activity.student),
              user))
        .call activity
    end

    def self.notify_teachers activity, user
      Notifier::Update
        .new(Scope::Exclude.new(
              Scope::Classroom::Subject::Teachers.new(activity.lesson.day.classroom, activity.lesson.subject), user))
        .call activity
    end

    def self.user_role user, activity
      if user.owns? activity.student.school
        'School Owner'
      elsif user.administrates? activity.student.school
        'School Admin'
      elsif user.teaches_subject_in_classroom? activity.lesson.subject, activity.lesson.day.classroom
        'Teacher'
      elsif user.follows? activity.student
        'Parent'
      end
    end
  end
end
