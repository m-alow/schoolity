module Api
  module V1
    class CommentsController < ApiController
      # PUT /api/v1/comments/1
      def update
        comment = Comment.find params[:id]
        authorize comment

        respond_to do |format|
          if comment.update(body: params[:comment][:body])
            format.json { render json: comment }
          else
            format.json { render json: { errors: comment.errors.full_messages } }
          end
        end
      end

      # DELETE /api/v1/comments/1
      def destroy
        comment = Comment.find params[:id]
        authorize comment
        comment.destroy
        respond_to do |format|
          format.json { render json: 'deleted', status: :ok }
        end
      end
    end
  end
end
