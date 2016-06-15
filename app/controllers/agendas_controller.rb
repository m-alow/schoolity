class AgendasController < ApplicationController
  before_action :set_day, only: [:update, :destroy]
  before_action :set_classroom, only: [:update, :destroy]
  before_action :set_classroom_from_params, only: [:show_by_date, :index, :today, :edit]

  # GET /classrooms/1/agendas
  def index
    DayPolicy.new(current_user, @classroom).authorize_action(:index?)
  end

  # GET /classrooms/1/agendas/2010-10-10
  def show_by_date
    authorize @classroom.days.build

    @date = params[:date].to_date
    @day = @classroom.day_at @date
    unless @day
      timetable = @classroom.current_timetable
      if timetable.present?
        unless timetable.weekend? @date
          @day = Day.make_with_lessons(classroom: @classroom, date: @date)
        else
          render :weekend
        end
      else
        render :no_timetable
      end
    end
  end

  # GET/classrooms/1/agendas/today
  def today
    date = Date.current
    redirect_to date_classroom_agendas_url(classroom_id: @classroom.id, date: date.to_param)
  end


  # # GET /agendas/new
  # def new
  #   @agenda = Agenda.new
  # end

  # GET /classrooms/1/agendas/2010-10-10/edit
  def edit
    @day = @classroom.days.build
    authorize @day

    # @date = params[:date].to_date
    # @day = @classroom.day_at @date

    # if @day.present?

    # else
    #   current_timetable = @classroom.current_timetable
    #   if current_timetable.present?
    #     unless current_timetable.weekend? @date
    #       @day = Day.make_with_lessons(classroom: @classroom, date: @date).tap { |day| day.save! }
    #     else
    #       render :weekend
    #     end
    #   else
    #     render :no_timetable
    #   end
    # end
  end

  # # POST /agendas
  # def create
  #   @agenda = Agenda.new(agenda_params)

  #   respond_to do |format|
  #     if @agenda.save
  #       format.html { redirect_to @agenda, notice: 'Agenda was successfully created.' }
  #       format.json { render :show, status: :created, location: @agenda }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @agenda.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /agendas/1
  def update
    authorize @day
    redirect_to today_classroom_agendas_url(@classroom)

    # if @agenda.update(agenda_params)
    #   redirect_to @agenda, notice: 'Agenda was successfully updated.'
    # else
    #   render :edit
    # end
  end

  # DELETE /agendas/1
  # DELETE /agendas/1.json
  def destroy
    authorize @day
    redirect_to today_classroom_agendas_url(@classroom)

    # @agenda.destroy
    # redirect_to agendas_url, notice: 'Agenda was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_day
    @day = Day.find(params[:id])
  end

  def set_classroom
    @classroom = @day.classroom
  end

  def set_classroom_from_params
    @classroom = Classroom.find(params[:classroom_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def agenda_params
    params.fetch(:agenda, {})
  end
end
