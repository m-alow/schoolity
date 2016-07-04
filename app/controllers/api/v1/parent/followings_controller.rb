module Api
  module V1
    module Parent
      class FollowingsController < ApiController
        def index
          respond_to do |format|
            format.json { render json: current_user.followings }
          end
        end

        def create
          following = current_user.follow_student(
            code: params[:following][:code],
            relationship: params[:following][:relationship],
            full_name: params[:following][:full_name])

          if following.save
            render json: following
          else
            render json: { errors: following.errors.full_messages }, status: :unprocessable_entity
          end
        end

        def destroy
          following = Following.find(params[:id])
          authorize following
          following.destroy
          render json: 'Successfully unfollowed.', status: :ok
        end
      end
    end
  end
end
