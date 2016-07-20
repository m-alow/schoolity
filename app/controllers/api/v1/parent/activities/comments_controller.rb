module Api
  module V1
    module Parent
      module Activities

        class CommentsController < ApiController
          def index
            activity = Activity.find params[:activity_id]

            respond_to do |format|
              format.json { render json: activity.comments, status: :ok, current_user: current_user.id  }
            end
          end

          def create
            activity = Activity.find params[:activity_id]
            respond_to do |format|
              Commenting::CommentOnActivity.call(activity, current_user, params[:comment][:body]) do
                on(:success) do |comment|
                  format.json { render json: comment, status: :ok, current_user: current_user.id  }
                end
                on(:invalid) do
                  format.json { render json: { errors: ['Comment cannot be blank.'] }, status: :unprocessable_entity }
                end
              end
            end
          end
        end

      end
    end
  end
end
