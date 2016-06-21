module Api::V1::Parent
  class TimetablesController < ::ApplicationController
    def current
      following = Following.find params[:following_id]
      student = following.student
      authorize student.classroom.timetables.build

      timetable = student.classroom.current_timetable
      if timetable.present?
        render json: timetable, status: :ok
      else
        render json: 'There is no timetable.', status: :not_found
      end
    end
  end
end
