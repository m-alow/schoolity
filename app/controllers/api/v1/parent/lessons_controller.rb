module Api
  module V1
    module Parent
      class LessonsController < ApiController
        def show
          lesson = Lesson.find params[:id]
          authorize lesson
          respond_to do |format|
            format.json { render json: lesson, status: :ok }
          end
        end
      end
    end
  end
end
