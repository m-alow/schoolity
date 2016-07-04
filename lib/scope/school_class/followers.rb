require 'scope/school_class/students'

module Scope
  module SchoolClass
    class Followers
      attr_reader :school_class, :students

      def initialize school_class
        @school_class = school_class
        @students = Scope::SchoolClass::Students.new(school_class).call
      end

      def call
        User
          .where(id:
                   Following
                  .select(:user_id)
                  .where(student_id: students))
      end

      def role
        'Follower'
      end
    end
  end
end
