class AgendasController < ApplicationController
  before_action :set_agenda, only: [:edit, :update, :destroy]
  before_action :set_classroom, only: [:edit, :update, :destroy]
  before_action :set_classroom_from_params, only: [:show_by_date, :index, :today]

  # GET /classrooms/1/agendas
  def index
    @agendas = Agenda.all
  end

  # GET /classrooms/1/agendas/2010/10/10
  def show_by_date
    @day = @classroom.days.build
    authorize @day

    timetable = @classroom.current_timetable
    if timetable.present?
      @date = Date.new params[:year].to_i, params[:month].to_i, params[:day].to_i
      unless @classroom.current_timetable.weekend? @date
        @day = @classroom.day_at @date
        unless @day.present?
          @day = Day.make_with_lessons(classroom: @classroom, date: @date).tap { |d| d.save! }
        end
      else
        render :weekend, notice: 'Today is a weekend.'
      end
    else
      render :no_timetable, notice: 'There is no timetable for this classroom.'
    end
  end

  # GET/classrooms/1/agendas/today
  def today
    date = Date.current
    redirect_to date_classroom_agendas_url(classroom_id: @classroom.id, year: date.year, month: date.month, day: date.day)
  end


  # # GET /agendas/new
  # def new
  #   @agenda = Agenda.new
  # end

  # GET /agendas/1/edit
  def edit
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
    if @agenda.update(agenda_params)
      redirect_to @agenda, notice: 'Agenda was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /agendas/1
  # DELETE /agendas/1.json
  def destroy
    @agenda.destroy
    redirect_to agendas_url, notice: 'Agenda was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_agenda
    @agenda = Agenda.find(params[:id])
  end

  def set_classroom
    @classroom = @timetable.classroom
  end

  def set_classroom_from_params
    @classroom = Classroom.find(params[:classroom_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def agenda_params
    params.fetch(:agenda, {})
  end
end
