class Admin::PanelController < ApplicationController
  include EnsureAdmin

  def index
    render locals: { schools: (current_user.schools + current_user.administrated_schools).uniq }
  end
end
