class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!
  def home
    if signed_in?
      redirect_to user_root_url
    end
  end

  def about
  end
end
