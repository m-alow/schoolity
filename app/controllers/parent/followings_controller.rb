class Parent::FollowingsController < ApplicationController
  # GET /parent/followings/1
  def show
    following = Following.find params[:id]
    authorize following
    render locals: { following: following, student: following.student }
  end
end
