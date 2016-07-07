module CommentsHelper
  def discuss_link commentable
    if commentable.persisted?
      link_to('Discuss', commentable) +
        unless commentable.comments.empty?
          ' ' + content_tag(:span, commentable.comments.count, class: 'badge')
        else
          ''
        end.html_safe
    else
      ''
    end
  end
end
