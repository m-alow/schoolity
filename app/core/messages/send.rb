module Messages
  class Send < Rectify::Command
    attr_reader :following, :author, :attributes
    def initialize following, author, attributes
      @following = following
      @author = author
      @attributes = attributes
    end

    def call
      authorize
      message = build_message
      if message.save
        broadcast(:success, message)
      else
        broadcast(:fail, message)
      end
    end

    private

    def authorize
      Pundit.authorize author, following, :show?
    end

    def build_message
      Message.make(
        student: following.student,
        user: author,
        message_type: attributes[:type],
        **attributes.deep_symbolize_keys)
    end
  end
end
