module Scope
  module School
    class Admins
      attr_reader :school

      def initialize school
        @school = school
      end

      def call
        User.where(id: SchoolAdministration.select(:user_id).where(school_id: school) ) +
          [ school.owner ]
      end

      def role
        'Admin'
      end
    end
  end
end
