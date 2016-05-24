class Students::FollowingCodesController < ApplicationController
  before_action :set_following_code, only: [:show, :destroy]
  before_action :set_student, only: [:show, :destroy]
  before_action :set_student_from_params, only: [:index, :create]

  after_action :verify_authorized, except: :index

  def index
    FollowingCodePolicy.new(current_user, @student.school).authorize_action(:index?)
    @following_codes = @student.following_codes.order(:expire_at).select { |f| !f.expired? }
  end

  def show
    authorize @following_code
  end

  def create
    @following_code = FollowingCode.make @student
    authorize @following_code

    @following_code.save!
    redirect_to @following_code, notice: 'Following code was successfully generated.'
  end

  def destroy
    authorize @following_code
    @following_code.destroy
    redirect_to student_following_codes_url(@student), notice: 'Following code was successfully deleted.'
  end

  private

  def set_following_code
    @following_code = FollowingCode.find params[:id]
  end

  def set_student
    @student = @following_code.student
  end

  def set_student_from_params
    @student = Student.find(params[:student_id])
  end
end
