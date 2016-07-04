class Parent::AgendasController < ApplicationController
  before_action :set_following

  # GET /parent/followings/1/agendas
  def index
    authorize @following, :show?
  end

  # GET /parent/followings/1/agendas/2010-10-10
  def show
    authorize @following
  end

  private

  def set_following
    @following = Following.find params[:following_id]
  end
end
