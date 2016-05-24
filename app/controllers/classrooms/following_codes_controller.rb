class Classrooms::FollowingCodesController < ApplicationController
  before_action :set_classroom_from_params, only: [:index, :create]
  after_action :verify_authorized, except: :index

  def index
    FollowingCodePolicy.new(current_user, @classroom.school).authorize_action(:index?)
    @following_codes = @classroom.following_codes
  end

  def create
    FollowingCode.transaction do
      @classroom.students.each do |student|
        following_code = FollowingCode.make student
        authorize following_code
        following_code.save!
      end
    end
    redirect_to classroom_following_codes_url(@classroom), notice: 'Following codes was successfully generated.'
  end

  private

  def set_classroom_from_params
    @classroom = Classroom.find params[:classroom_id]
  end
end
