module Commenting
  class CommentOnMessage < Rectify::Command
    def self.new(message, user, body)
      Commenting::Comment.new(
        commentable: message,
        user: user,
        body: body,
        role: -> (u) { user_role u, message },
        notify: -> (message) { notify message, user }
      )
    end

    private

    def self.notify message, user
      notify_author message, user
      notify_admins message, user
    end

    def self.notify_author message, user
      scope = Struct.new :call, :role
      Notifier::Update
        .new(Scope::Exclude.new(
              scope.new([message.user], 'Follower') , user))
        .call message
    end

    def self.notify_admins message, user
      Notifier::Update
        .new(Scope::Exclude.new(
              Scope::School::Admins.new(message.student.school), user))
        .call message
    end

    def self.user_role user, message
      school = message.student.school
      if user.owns? school
        'School Owner'
      elsif user.administrates? school
        'School Admin'
      elsif user == message.user
        'Parent'
      end
    end
  end
end
