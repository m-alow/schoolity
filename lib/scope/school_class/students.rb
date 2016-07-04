module Scope
  module SchoolClass
    class Students
      attr_reader :school_class

      def initialize school_class
        @school_class = school_class
      end

      def call
        ::Student
          .where(id: Studying
                       .select(:student_id)
                       .where(classroom: school_class.classrooms))
      end

      def role
        'Student'
      end
    end
  end
end
