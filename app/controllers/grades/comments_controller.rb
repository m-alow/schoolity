class Grades::CommentsController < ApplicationController
  # POST /grades/1/comments
  def create
    grade = Grade.find params[:grade_id]
    respond_to do |format|
      Commenting::CommentOnGrade.call(grade, current_user, params[:comment][:body]) do
        on(:success) do |comment|
          @comment = comment
          format.html { redirect_to grade, notice: 'Comment was successfully added.' }
          format.js { render 'comments/create', locals: { comment: comment } }
        end
        on(:invalid) do
          format.html { redirect_to grade, notice: 'Comment was not added.' }
          format.js { render nothing: true }
        end
      end
    end
  end
end
