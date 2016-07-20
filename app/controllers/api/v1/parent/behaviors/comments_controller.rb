module Api
  module V1
    module Parent
      module Behaviors

        class CommentsController < ApiController
          def index
            behavior = Behavior.find params[:behavior_id]

            respond_to do |format|
              format.json { render json: behavior.comments, status: :ok, current_user: current_user.id  }
            end
          end

          def create
            behavior = Behavior.find params[:behavior_id]
            respond_to do |format|
              Commenting::CommentOnBehavior.call(behavior, current_user, params[:comment][:body]) do
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
