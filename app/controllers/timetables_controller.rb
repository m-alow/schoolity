class TimetablesController < ApplicationController
  before_action :set_timetable, only: [:show, :edit, :update, :destroy]
  before_action :set_classroom, only: [:show, :edit, :update, :destroy]
  before_action :set_classroom_from_params, only: [:index, :init, :new, :create]
  after_action :verify_authorized, except: :index

  # GET /classrooms/1/timetables
  def index
    TimetablePolicy.new(current_user, @classroom).authorize_action(:index?)
    @timetables = @classroom.current_timetables
  end

  # GET /timetables/1
  def show
    authorize @timetable
    @periods = @timetable.periods_hash
  end

  # GET /classrooms/1/new/init
  def init
    @timetable = @classroom.timetables.build
    authorize @timetable
  end

  # GET /classrooms/1/timetables/new
  def new
    session[:periods_number] = params.fetch(:timetable, {})[:periods_number].to_i
    session[:weekends] = [params[:Friday], params[:Saturday], params[:Sunday], params[:Monday],
                          params[:Tuesday], params[:Wednesday], params[:Thursday]].reject(&:nil?)

    @timetable = @classroom.timetables.build(periods_number: session[:periods_number], weekends: session[:weekends])
    @periods = empty_periods_hash

    authorize @timetable

    @timetable.validate
    unless @timetable.errors[:periods_number].empty?
      render :init
    end
  end

  # GET /timetables/1/edit
  def edit
    authorize @timetable
    @periods = @timetable.periods_hash
  end

  # POST /classrooms/1/timetables
  def create
    @timetable = @classroom.timetables.build(
      active: params[:timetable][:active],
      periods_number: session[:periods_number],
      weekends: session[:weekends])

    authorize @timetable

    @timetable.build_periods timetable_params

    if @timetable.save
      session.delete(:periods_number)
      session.delete(:weekends)
      redirect_to @timetable, notice: 'Timetable was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /timetables/1
  def update
    authorize @timetable

    Timetable.transaction do
      @timetable.update(active: params[:timetable][:active])
      @timetable.update_periods timetable_params
    end
    redirect_to @timetable, notice: 'Timetable was successfully updated.'
  rescue
    @periods = @timetable.periods_hash
    render :edit
  end

  # DELETE /timetables/1
  def destroy
    authorize @timetable

    @timetable.destroy
    redirect_to classroom_timetables_url(@classroom), notice: 'Timetable was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_timetable
      @timetable = Timetable.find(params[:id])
    end

    def set_classroom
      @classroom = @timetable.classroom
    end

    def set_classroom_from_params
      @classroom = Classroom.find(params[:classroom_id])
    end

    def timetable_params
      @timetable.study_days.map do |day|
        @timetable.periods_number.times.map do |period|
          { day: day, order: period + 1, subject_id: params[day]["#{period + 1}"][:period][:subject_id] }
        end
      end.flatten
    end

    def empty_periods_hash
      Hash.new Hash.new Period.new
    end
end
