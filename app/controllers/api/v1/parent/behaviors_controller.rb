module Api
  module V1
    module Parent
      class BehaviorsController < ApiController
        # GET /api/v1/parent/followings/1/behaviors
        def index
          @following = Following.find params[:following_id]
          authorize @following, :show?

          respond_to do |format|
            format.json { render json: @following.student.behaviors, user_id: current_user.id }
          end
        end

        # GET /api/v1/parent/behaviors/1
        def show
          behavior = Behavior.find params[:id]
          respond_to do |format|
            format.json { render json: behavior, user_id: current_user.id }
          end
        end
      end
    end
  end
end
