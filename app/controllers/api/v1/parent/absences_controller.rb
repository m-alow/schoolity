module Api
  module V1
    module Parent
      class AbsencesController < ApiController
        # GET /api/v1/parent/followings/1/absences
        def index
          @following = Following.find params[:following_id]
          authorize @following, :show?

          respond_to do |format|
            format.json { render json: @following.student.absences }
          end
        end

        # GET /api/v1/parent/absences/1
        def show
          absence = Absence.find params[:id]
          respond_to do |format|
            format.json { render json: absence }
          end
        end
      end
    end
  end
end
