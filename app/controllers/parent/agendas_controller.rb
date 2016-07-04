require_dependency 'day/on_date'

class Parent::AgendasController < ApplicationController
  before_action :set_following

  # GET /parent/followings/1/agendas
  def index
    authorize @following, :show?
  end

  # GET /parent/followings/1/agendas/2010-10-10
  def show
    authorize @following

    @date = params[:date].to_date
    @classroom = @following.student.classroom
    unless @classroom.present?
      flash.now[:alert] = 'No classroom'
      return render(:missing)
    end

    day_result = DayOnDate.new.call @classroom, @date
    case day_result.status
    when :study_day
      @day = day_result.day
    when :weekend
      flash.now[:alert] = 'Weekend'
      render :missing, notice: 'Weekend'
    when :no_timetable
      flash.now[:alert] = 'No Timetable'
      render :missing
    end
  end

  private

  def set_following
    @following = Following.find params[:following_id]
  end
end
