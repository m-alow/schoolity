module Shared::ActionsHelper
  def panels_links
    links = ''
    if current_user
      links += "<li>#{link_to('Teacher Panel', teacher_path)}</li>" if current_user.teacher?
      links += "<li>#{link_to('Parent Panel', parent_panel_path)}</li>" if current_user.parent?
      links = "<li>#{link_to('Dashboard', dashboard_path)}</li>" if links.empty?
    end
    links.html_safe
  end
end
