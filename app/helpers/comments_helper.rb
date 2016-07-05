module CommentsHelper
  def discuss_link commentable
    link_to('Discuss', commentable) + ' ' +
      content_tag(:span, commentable.comments.count, class: 'badge')
  end
end
