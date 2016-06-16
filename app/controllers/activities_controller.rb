class ActivitiesController < ApplicationController
  def update
    @lesson = Lesson.find(params[:lesson_id])
    @student = Student.find(params[:student_id])

    authorize Activity.new lesson: @lesson, student: @student

    @activity = Activity.find_by lesson: @lesson, student: @student
    unless @activity.present?
      @activity = Activity.make lesson: @lesson, student: @student
    end

    @activity.update_content(params[:activity].deep_symbolize_keys).tap { |a| a.save! }

    respond_to do |format|
      format.html { redirect_to edit_lesson_activities_url(@lesson) }
      format.js
    end
  end
end
