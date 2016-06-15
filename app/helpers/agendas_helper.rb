module AgendasHelper
  def day_link date
    link_to date.day,
            date_classroom_agendas_path(classroom_id: @classroom, date: date.to_param),
            class: "calendar_link",
            id: "day-link-#{date.day}"
  end

  def current_month
    @current_date ||= params[:start_date]&.to_date || Date.current
    @current_date.month
  end

  def current_month? date
    date.month == current_month
  end
end
