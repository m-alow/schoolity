module Api
  module V1
    module Parent
      class ActivitiesController < ApiController
        # GET /api/v1/parent/followings/1/activities
        def index
          @following = Following.find params[:following_id]
          authorize @following, :show?

          respond_to do |format|
            format.json { render json: @following.student.activities, user_id: current_user.id }
          end
        end

        # GET /api/v1/parent/activities/1
        def show
          activity = Activity.find params[:id]
          respond_to do |format|
            format.json { render json: activity, user_id: current_user.id }
          end
        end
      end
    end
  end
end
