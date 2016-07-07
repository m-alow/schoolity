module Api
  module V1
    module Parent
      class GradesController < ApiController
        # GET /api/v1/parent/followings/1/grades
        def index
          @following = Following.find params[:following_id]
          authorize @following, :show?

          respond_to do |format|
            format.json { render json: grouped_grades }
          end
        end

        private

        def grouped_grades
          @following.student
            .grades
            .includes(exam: :subject)
        end
      end
    end
  end
end
