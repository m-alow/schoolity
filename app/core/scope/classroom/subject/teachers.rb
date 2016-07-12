module Scope
  module Classroom
    module Subject
      class Teachers
        attr_reader :classroom, :subject

        def initialize classroom, subject
          @classroom = classroom
          @subject = subject
        end

        def call
          User.where(id: (
                       Teaching.select(:user_id).where(classroom: classroom, subject: subject) +
                       Teaching.select(:user_id).where(classroom: classroom, all_subjects: true)).map(&:user_id))

        end

        def role
          'Teacher'
        end
      end
    end
  end
end
