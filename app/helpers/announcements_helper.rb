module AnnouncementsHelper
  def announcements_path announcement
    if announcement.for_school?
      school_announcements_path announcement.announceable
    elsif announcement.for_school_class?
      school_class_announcements_path announcement.announceable
    elsif announcement.for_classroom?
      classroom_announcements_path announcement.announceable
    end
  end
end
