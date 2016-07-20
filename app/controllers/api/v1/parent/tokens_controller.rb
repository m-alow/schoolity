module Api
  module V1
    module Parent
      class TokensController < ApiController
        # POST /api/v1/parent/tokens
        def create
          token = DeviceToken.create user: current_user,
                                     token: params[:token],
                                     role: 'Follower'
          respond_to do |format|
            format.json { render json: { token: params[:token] }, status: :ok }
          end
        end
      end
    end
  end
end
