module Commenting
  class Comment < Rectify::Command
    def initialize(commentable:, user:, notify:, role:, body:)
      @commentable = commentable
      @user = user
      @notify = notify
      @role = role
      @body = body
    end

    def call
      comment = build_comment

      authorize_comment comment

      if comment.save
        notify.call commentable
        broadcast :success, comment
      else
        broadcast :invalid
      end
    end

    private

    attr_reader :commentable, :user, :notify, :role, :body

    def build_comment
      commentable.comments.build user: user,
                                 role: role.(user),
                                 body: body
    end

    def authorize_comment comment
      Pundit.authorize(user, comment.commentable, :show?)
    end
  end
end
