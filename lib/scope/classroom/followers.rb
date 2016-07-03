module Scope
  module Classroom
    class Followers
      attr_reader :classroom

      def initialize classroom
        @classroom = classroom
      end

      def call
        User.where id:
                     Following.select(:user_id).where(student_id: classroom.students)
      end

      def role
        'Follower'
      end
    end
  end
end
