class Activities::CommentsController < ApplicationController
  # POST /activities/1/comments
  def create
    activity = Activity.find params[:activity_id]
    respond_to do |format|
      Commenting::CommentOnActivity.call(activity, current_user, params[:comment][:body]) do
        on(:success) do |comment|
          @comment = comment
          format.html { redirect_to activity, notice: 'Comment was successfully added.' }
          format.js { render 'comments/create', locals: { comment: comment } }
        end
        on(:invalid) do
          format.html { redirect_to activity, notice: 'Comment was not added.' }
          format.js { render nothing: true }
        end
      end
    end
  end
end
