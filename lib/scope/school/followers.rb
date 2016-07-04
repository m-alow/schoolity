module Scope
  module School
    class Followers
      attr_reader :school

      def initialize school
        @school = school
      end

      def call
        User.where(id: Following.select(:user_id).where(student_id: school.students))
      end

      def role
        'Follower'
      end
    end
  end
end
