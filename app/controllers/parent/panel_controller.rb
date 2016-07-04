class Parent::PanelController < ApplicationController
  include EnsureParent

  def index
    render locals: { followings: current_user.followings }
  end
end
