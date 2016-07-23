module Api
  module V1
    module Parent
      class LessonsController < ApiController
        def show
          lesson = Lesson.find params[:id]
          authorize lesson
          student = Following.find_by(user: current_user, student: lesson.day.classroom.students).student
          respond_to do |format|
            format.json { render json: lesson, student_id: student, status: :ok }
          end
        end
      end
    end
  end
end
