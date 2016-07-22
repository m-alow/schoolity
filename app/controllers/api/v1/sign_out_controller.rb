class Api::V1::SignOutController < Api::V1::ApiController
  def destroy
    current_user.update(authentication_token: nil)
    DeviceToken.where(user: current_user, role: 'Follower').update_all(enabled: false)
    respond_to do |format|
      format.json { render json: 'signed out', status: :ok }
    end
  end
end
