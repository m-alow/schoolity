module AnnouncementsHelper
  def announcements_path announcement
    send "#{announcement.announceable_type.underscore}_announcements_path", announcement.announceable
  end
end
