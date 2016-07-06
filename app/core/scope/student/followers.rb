module Scope
  module Student
    class Followers
      attr_reader :student

      def initialize student
        @student = student
      end

      def call
        User.where id: Following.select(:user_id).where(student_id: student)
      end

      def role
        'Follower'
      end
    end
  end
end
