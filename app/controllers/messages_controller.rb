class MessagesController < ApplicationController
  # GET /messages/1
  def show
    @message = Message.find params[:id]
    authorize @message
    render locals: { message: @message }
  end

  # GET /schools/1/messages
  def index
    @school = School.find params[:school_id]
    render locals: { messages: @school.messages.sorted.paginate(page: params[:page]) }
  end

  # GET /schools/1/messages/category
  def index_category
    @school = School.find params[:school_id]
    render locals: { messages: @school.messages.where(message_type: params[:category].singularize).sorted.paginate(page: params[:page]) }
  end

end
