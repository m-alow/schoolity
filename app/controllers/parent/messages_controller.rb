class Parent::MessagesController < ApplicationController
  before_action :set_following

  # GET /parent/followings/1/messages/new
  def new

    authorize @following, :show?
    @message = Message.make
  end

  # POST /parent/followings/1/messages
  def create
    Messages::Send.(@following, current_user, params[:message]) do
      on(:success) { |message| redirect_to message, notice: 'Your message was successfully sent.' }
    end
  end

  private

  def set_following
    @following = Following.find params[:following_id]
  end
end
