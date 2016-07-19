class MessagesController < ApplicationController
  def show
    @message = Message.find params[:id]
    authorize @message
    render locals: { message: @message }
  end
end
