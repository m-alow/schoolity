module Scope
  module Classroom
    class Teachers
      attr_reader :classroom

      def initialize classroom
        @classroom = classroom
      end

      def call
        User.where id: Teaching.select(:user_id).where(classroom: classroom)
      end

      def role
        'Teacher'
      end
    end
  end
end
