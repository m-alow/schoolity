class Absences::CommentsController < ApplicationController
  # POST /absences/1/comments
  def create
    absence = Absence.find params[:absence_id]
    respond_to do |format|
      Commenting::CommentOnAbsence.(absence, current_user, params[:comment][:body]) do
        on(:success) do |comment|
          format.html { redirect_to absence, notice: 'Comment was successfully added.' }
          format.js { render 'comments/create', locals: { comment: comment } }
        end
        on(:invalid) do
          format.html { redirect_to absence, notice: 'Comment was not added.' }
          format.js { render nothing: true }
        end
      end
    end
  end
end
