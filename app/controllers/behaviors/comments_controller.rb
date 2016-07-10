class Behaviors::CommentsController < ApplicationController
  # POST /behaviors/1/comments
  def create
    behavior = Behavior.find params[:behavior_id]
    respond_to do |format|
      Commenting::CommentOnBehavior.call(behavior, current_user, params[:comment][:body]) do
        on(:success) do |comment|
          format.html { redirect_to behavior, notice: 'Comment was successfully added.' }
          format.js { render 'comments/create', locals: { comment: comment } }
        end
        on(:invalid) do
          format.html { redirect_to behavior, notice: 'Comment was not added.' }
          format.js { render nothing: true }
        end
      end
    end
  end
end
