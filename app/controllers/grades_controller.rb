class GradesController < ApplicationController
  def show
    @grade = Grade.find params[:id]
    authorize @grade
  end
end
