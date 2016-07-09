class Lessons::BehaviorsController < ApplicationController
  before_action :set_lesson

  # GET /lessons/:lesson_id/behaviors
  def index
    LessonBehaviorPolicy.new(current_user, @lesson).authorize_action(:index?)
  end

  # GET /lessons/:lesson_id/behaviors/edit
  def edit
    LessonBehaviorPolicy.new(current_user, @lesson).authorize_action(:edit?)
  end

  # GET /lessons/:lesson_id/students/:student_id/behavior
  def update
    student = Student.find params[:student_id]
    LessonBehaviorPolicy.new(current_user, Behavior.new(student: student, behaviorable: @lesson)).authorize_action(:update?)

    behavior = Behavior.find_by behaviorable: @lesson, student: student
    unless behavior.present?
      behavior = Behavior.make behaviorable: @lesson, student: student
    end
    behavior.update_content(params[:behavior].deep_symbolize_keys).tap { |b| b.save! }

    respond_to do |format|
      format.html { redirect_to edit_lesson_behaviors_url(@lesson) }
      format.js
    end
  end

  private

  def set_lesson
    @lesson = Lesson.find params[:lesson_id]
  end
end
