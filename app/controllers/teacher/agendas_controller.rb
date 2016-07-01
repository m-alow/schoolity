require 'teacher_lessons'

class Teacher::AgendasController < ApplicationController
  include EnsureTeacher

  # GET /teacher/agendas
  def index
  end

  # GET /teacher/agendas/2010-10-5
  def show
    @date = params[:date].to_date
    @classrooms_with_lessons = classroom_with_lessons @date
    flash.alert = 'There is nothing to do today.' if @classrooms_with_lessons.empty?
  end

  # GET /teacher/agendas/2010-10-5/edit
  def edit
  end

  private

  def classroom_with_lessons date
    TeacherLessons
      .new
      .call(current_user, date)
      .sort_by { |cl| [cl.classroom.school,
                       cl.classroom.school_class,
                       cl.classroom] }
  end
end
