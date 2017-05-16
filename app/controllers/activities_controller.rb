class ActivitiesController < ApplicationController
  def edit
    @activity = Activity.find(params[:id])
  end

  def update
    @activity = Activity.find(params[:id])
    @activity.update(activity_params)
  end

  private

  def activity_params
    params.require(:activity).permit(:name, :intro, :start_time, :terminate_time)
  end

end
