class MessagesController < ApplicationController
  def show
    @message = Message.find params[:id]
    authorize @message
  end
end
