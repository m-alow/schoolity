require 'day/persisted_on_date'

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

  def update_qualified
    @classroom = Classroom.find params[:classroom_id]
    @date = params[:date].to_date
    @order = params[:order].to_i

    return update_failure(@date) unless lesson.present?

    authorize lesson

    lesson.update_content(lesson_params).tap { |l| l.save! }
    update_success @date
  end

  private

  def update_success date
    respond_to do |format|
      format.html { redirect_to teacher_agenda_url date }
      format.js { render locals: { classroom_id: @classroom.id, lesson: lesson } }
    end
  end

  def update_failure date
    respond_to do |format|
      format.html do
        flash.now.alert = 'There is no corresponding lesson.'
        format.html { redirect_to teacher_agenda_url datea }
      end
    end
  end

  def lesson_params
    params[:lesson].deep_symbolize_keys
  end

  def day
  end

  def lesson
    @res ||= PersistedDayOnDate.new.call @classroom, @date
    @day ||= @res.day if @res.status == :study_day
    @lesson ||= @day.lessons.detect { |l| l.order == @order }
  end
end
