module Notifier
  module Presenter
    class Grade
      attr_reader :grade
      def initialize grade
        @grade = grade
      end

      def present
        "New #{summary}"
      end

      def summary
        "#{grade.exam.subject.name} grade for #{grade.student.name}"
      end
    end
  end
end
