module Scope
  module Classroom
    class Followers
      def call classroom
        User.where id:
                     Following.select(:user_id).where(student_id: classroom.students)
      end

      def role
        'Follower'
      end
    end
  end
end
