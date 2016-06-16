class LessonsController < ApplicationController
  def update
    @lesson = Lesson.find(params[:id])
    authorize @lesson

    @lesson.update_content(params[:lesson].deep_symbolize_keys).save!

    respond_to do |format|
      format.html { redirect_to edit_classroom_agendas_url(classroom_id: @lesson.day.classroom.id, date: @lesson.day.date.to_param) }
      format.js
    end
  end
end
