module Api
  module V1
    module Parent
      class TimetablesController < ApiController
        def current
          following = Following.find params[:following_id]
          student = following.student
          authorize student.classroom.timetables.build classroom: student.classroom

          timetable = student.classroom.current_timetable
          if timetable.present?
            render json: timetable, status: :ok
          else
            render json: { errors: ['There is no timetable.'] }, status: :not_found
          end
        end
      end
    end
  end
end
