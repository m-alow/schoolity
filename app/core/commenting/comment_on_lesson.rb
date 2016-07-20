module Commenting
  class CommentOnLesson < Rectify::Command
    def self.new(lesson, user, body)
      Commenting::Comment.new(
        commentable: lesson,
        user: user,
        body: body,
        role: -> (u) { user_role u, lesson },
        notify: -> (lesson) { notify lesson, user }
      )
    end

    private

    def self.notify lesson, user
      notify_followers lesson, user
      notify_teachers lesson, user
    end

    def self.notify_followers lesson, user
      Notifier::Update
        .new(Scope::Exclude.new(
              Scope::Classroom::Followers.new(lesson.day.classroom),
              user))
        .call lesson
    end

    def self.notify_teachers lesson, user
      Notifier::Update
        .new(Scope::Exclude.new(
              Scope::Classroom::Subject::Teachers.new(lesson.day.classroom, lesson.subject),
              user))
        .call lesson
    end

    def self.user_role user, lesson
      school = lesson.day.classroom.school
      if user.owns? school
        'School Owner'
      elsif user.administrates? school
        'School Admin'
      elsif user.teaches_subject_in_classroom? lesson.subject, lesson.day.classroom
        'Teacher'
      elsif user.follows_student_in_classroom? lesson.day.classroom
        'Parent'
      end
    end
  end
end
