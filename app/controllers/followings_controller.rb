class FollowingsController < ApplicationController
  before_action :set_following, only: [:show, :destroy]
  after_action :verify_authorized

  # GET /followings
  def index
    authorize Following
    @followings = current_user.followings
  end

  # GET /followings/1
  def show
    authorize @following
  end

  # GET /followings/new
  def new
    authorize Following
    @following = current_user.followings.build
  end

  # POST /followings
  def create
    authorize Following
    @following = current_user.follow_student(
      code: params[:following_code],
      relationship: params[:following][:relationship],
      full_name: params[:student_full_name])

    if @following.save
      redirect_to @following, notice: "#{params[:student_full_name]} was successfully followed."
    else
      render :new
    end
  end

  # DELETE /followings/1
  def destroy
    authorize @following
    @following.destroy
    redirect_to followings_url, notice: "You've just unfollowed #{@following.student.name}."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_following
      @following = Following.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def following_params
      params.require(:following).permit(:relationship)
    end
end
