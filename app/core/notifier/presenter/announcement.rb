module Notifier
  module Presenter
    class Announcement
      attr_reader :announcement
      def initialize announcement
        @announcement = announcement
      end

      def present
        "New #{summary}"
      end

      def summary
        "announcement for #{announceable}"
      end

      private

      def announceable
        announceable = announcement.announceable
        case announcement.announceable_type
        when 'School'
          "school #{announceable.name}"
        when 'SchoolClass'
          "class #{announceable.name}"
        when
          'Classroom'
          "classroom #{announceable.name} in #{announceable.school_class.name}"
        when 'Student'
          "student #{announceable.name}"
        end
      end
    end
  end
end
