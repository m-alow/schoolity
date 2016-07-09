class BehaviorsController < ApplicationController
  def show
    @behavior = Behavior.find params[:id]
    authorize @behavior
  end
end
