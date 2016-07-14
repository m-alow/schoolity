module Commenting
  class CommentOnAnnouncement < Rectify::Command
    def self.new(announcement, user, body)
      Commenting::Comment.new(
        commentable: announcement,
        user: user,
        body: body,
        role: -> (u) { user_role u, announcement },
        notify: -> (announcement) { notify announcement, user }
      )
    end

    private

    def self.notify announcement, user
      notify_followers announcement, user
    end

    def self.notify_followers announcement, user
      followers_scope = "Scope::#{announcement.announceable_type}::Followers".constantize
      Notifier::Update
        .new(Scope::Exclude.new(
              followers_scope.new(announcement.announceable),
              user))
        .call announcement
    end

    def self.user_role user, announcement
      send announcement.announceable_type.underscore.+('_user_role'), user, announcement
    end

    def self.school_user_role user, announcement
      school = announcement.announceable
      if user.owns? school
        'School Owner'
      elsif user.administrates? school
        'School Admin'
      elsif user.teaches_in_school? school
        'Teacher'
      elsif user.follows_student_in_school? school
        'Parent'
      end
    end

    def self.school_class_user_role user, announcement
      school_class = announcement.announceable
      if user.owns? school_class.school
        'School Owner'
      elsif user.administrates? school_class.school
        'School Admin'
      elsif user.teaches_in_school_class? school_class
        'Teacher'
      elsif user.follows_student_in_school_class? school_class
        'Parent'
      end
    end

    def self.classroom_user_role user, announcement
      classroom = announcement.announceable
      if user.owns? classroom.school
        'School Owner'
      elsif user.administrates? classroom.school
        'School Admin'
      elsif user.teaches_in_classroom? classroom
        'Teacher'
      elsif user.follows_student_in_classroom? classroom
        'Parent'
      end
    end

    def self.student_user_role user, announcement
      student = announcement.announceable
      if user.owns? student.school
        'School Owner'
      elsif user.administrates? student.school
        'School Admin'
      elsif user.follows? student
        'Parent'
      end
    end
  end
end
