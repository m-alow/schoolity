class Lessons::CommentsController < ApplicationController
  # POST /lessons/1/comments
  def create
    lesson = Lesson.find params[:lesson_id]
    respond_to do |format|
      Commenting::CommentOnLesson.call(lesson, current_user, params[:comment][:body]) do
        on(:success) do |comment|
          @comment = comment
          format.html { redirect_to lesson, notice: 'Comment was successfully added.' }
          format.js { render 'comments/create', locals: { comment: comment } }
        end

        on(:invalid) do
          format.html { redirect_to lesson, notice: 'Comment was not added.' }
          format.js { render nothing: true }
        end
      end
    end
  end
end
