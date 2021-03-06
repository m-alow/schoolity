module Api
  module V1
    module Parent
      class AgendasController < ApiController
        def show_by_date
          following = Following.find params[:following_id]
          student = following.student
          date = "#{params[:year]}-#{params[:month]}-#{params[:day]}".to_date
          day_result = Day::OnDate.new.call student.classroom, date

          authorize Day.new classroom: student.classroom

          case day_result.status
          when :study_day
            render json: day_result.day, status: :ok, student_id: student.id
          when :weekend
            render json: { errors: ['Weekend'] }, status: :not_found
          when :no_timetable
            render json: { errors: ['There is no timetable.'] }, status: :not_found
          end
        end
      end
    end
  end
end
