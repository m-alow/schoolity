class Days::BehaviorsController < ApplicationController
  before_action :set_day

  # GET /days/:day_id/behaviors
  def index
    DayBehaviorPolicy.new(current_user, @day).authorize_action(:index?)
    @behaviors = @day.behaviors.includes(:student)
  end

  # GET /days/:day_id/behaviors/edit
  def edit
    DayBehaviorPolicy.new(current_user, @day).authorize_action(:edit?)
    @students = @classroom.students
  end

  # GET /days/:day_id/students/:student_id/behavior
  def update
    @student = Student.find params[:student_id]
    DayBehaviorPolicy.new(current_user, Behavior.new(student: @student, behaviorable: @day)).authorize_action(:update?)

    behavior = Behavior.find_by behaviorable: @day, student: @student
    unless behavior.present?
      behavior = Behavior.make behaviorable: @day, student: @student
    end
    behavior.update_content(params[:behavior].deep_symbolize_keys).tap { |b| b.save! }

    notify_followers behavior

    respond_to do |format|
      format.html { redirect_to edit_day_behaviors_url(@day) }
      format.js { render locals: { behavior: behavior } }
    end
  end

  private

  def set_day
    @day = Day.find params[:day_id]
    @classroom = @day.classroom
  end

  def notify_followers behavior
    Notifier::Update
      .new(Scope::Student::Followers.new(@student))
      .call behavior
  end
end
