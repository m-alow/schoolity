require 'teacher_classrooms'

class Teacher::PanelController < ApplicationController
  include EnsureTeacher

  def index
  end

  def exams
    @classrooms = teacher_classrooms
  end

  def announcements
    @classrooms = teacher_classrooms
  end

  private

  def teacher_classrooms
    TeacherClassrooms.new.call(current_user).
      sort_by { |c| [
                  c.school.name,
                  c.school_class.name,
                  c.name] }
  end
end
