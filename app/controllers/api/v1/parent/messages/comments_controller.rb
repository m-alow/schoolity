module Api
  module V1
    module Parent
      module Messages

        class CommentsController < ApiController
          def index
            message = Message.find params[:message_id]
            authorize message, :show?
            respond_to do |format|
              format.json { render json: message.comments, status: :ok, current_user: current_user.id  }
            end
          end

          def create
            message = Message.find params[:message_id]
            respond_to do |format|
              Commenting::CommentOnMessage.call(message, current_user, params[:comment][:body]) do
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
