class Parent::MessagesController < ApplicationController
  def new
    @following = Following.find params[:following_id]
    authorize @following, :show?
    @message = Message.make
  end
end
