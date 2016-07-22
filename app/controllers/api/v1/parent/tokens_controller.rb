module Api
  module V1
    module Parent
      class TokensController < ApiController
        # POST /api/v1/parent/tokens
        def create
          token = DeviceToken
                  .find_or_initialize_by(user: current_user,
                                         token: params[:token],
                                         role: 'Follower')
                  .tap { |token| token.enabled = true }
                  .save

          respond_to do |format|
            format.json { render json: { token: params[:token] }, status: :ok }
          end
        end
      end
    end
  end
end
