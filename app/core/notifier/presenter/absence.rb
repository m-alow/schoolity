module Notifier
  module Presenter
    class Absence
      attr_reader :absence
      def initialize absence
        @absence = absence
      end

      def present
        "New #{summary}"
      end

      def summary
        "absence of #{absence.student.name} on #{absence.day.date}"
      end
    end
  end
end
