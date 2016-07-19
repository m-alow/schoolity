class Messages::CommentsController < ApplicationController
  def create
    message = Message.find params[:message_id]
    authorize message, :show?

    respond_to do |format|
      Commenting::CommentOnMessage.call(message, current_user, params[:comment][:body]) do

        on(:success) do |comment|
          format.html { redirect_to message, notice: 'Comment was successfully added.' }
          format.js { render 'comments/create', locals: { comment: comment } }
        end

        on(:invalid) do
          format.html { redirect_to message, notice: 'Comment was not added.' }
          format.js { render nothing: true }
        end
      end
    end
  end
end
