class CommentsController < ApplicationController
  # PUT /comments/1
  def update
    comment = Comment.find params[:id]
    authorize comment

    respond_to do |format|
       if comment.update(body: params[:comment][:body])
        format.html { redirect_to comment.commentable }
        format.js { render locals: { comment: comment } }
      else
        format.html { redirect_to comment.commentable }
        format.js { render nothing: true }
      end
    end
  end

  # DELETE /comments/1
  def destroy
    comment = Comment.find params[:id]
    authorize comment
    comment.destroy
    respond_to do |format|
      format.js { render locals: { comment: comment } }
      format.html { redirect_to comment.commentable }
    end
  end
end
