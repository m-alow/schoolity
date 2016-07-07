module Commenting
  class CommentOnGrade < Rectify::Command
    def self.new(grade, user, body)
      Commenting::Comment.new(
        commentable: grade,
        user: user,
        body: body,
        role: -> (u) { user_role u, grade },
        notify: -> (grade) { notify_followers grade, user }
      )
    end

    private

    def self.notify_followers grade, user
      Notifier::Update
        .new(Scope::Exclude.new(
              Scope::Student::Followers.new(grade.student), user))
        .call grade
    end

    def self.user_role user, grade
      classroom = grade.exam.classroom
      if user.owns? classroom.school
        'School Owner'
      elsif user.administrates? classroom.school
        'School Admin'
      elsif user.teaches_subject_in_classroom? grade.exam.subject, classroom
        'Teacher'
      elsif user.follows? grade.student
        'Parent'
      end
    end
  end
end
