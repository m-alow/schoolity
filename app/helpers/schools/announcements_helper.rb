module Schools::AnnouncementsHelper
  def announcements_path announcement
    if announcement.for_school?
      school_announcements_path announcement.announceable
    end
  end
end
