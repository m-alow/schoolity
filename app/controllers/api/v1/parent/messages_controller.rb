module Api
  module V1
    module Parent
      class MessagesController < ApiController
        before_action :set_following, except: :show

        def index
          authorize @following, :show?
          messages = Message.where user: current_user, student: @following.student

          respond_to do |format|
            format.json { render json: messages, status: :ok }
          end
        end

        def create
          Messages::Send.(@following, current_user, params[:message]) do
            on(:success) { |message| render json: message, status: :ok }
          end
        end

        def show
          message = Message.find params[:id]
          authorize message
          respond_to do |format|
            format.json { render json: message, status: :ok }
          end
        end

        private

        def set_following
          @following = Following.find params[:following_id]
        end
      end
    end
  end
end
