class Teacher::PanelController < ApplicationController
  def index
    unless current_user.teacher?
      flash.now.notice = 'You are not a teacher'
      render 'non_teacher'
    end
  end
end
