module NotificationsHelper
  def notifiable_link notification
    c = notification.notifiable.comments.count
    link_to('Discuss', notification) +
      unless c.zero?
        ' ' + content_tag(:span, c, class: 'badge')
      else
        ''
      end.html_safe
  end
end
