class PlansController < ApplicationController
  
  #create a new plan
  def create
  	@plan = Plan.new(user_id: params[:user_id].to_i, event_id: params[:event_id].to_i)
  	if @plan.save
  		redirect_to events_index_path
  	else
  		flash[:plan_errors] = @plan.errors.full_messages
  		redirect_to "/events/#{@plan.event_id}"
  	end
  end

  #destroy a plan
  def destroy
    @plan = Plan.where(user: User.find(params[:user_id].to_i), event: Event.find(params[:event_id].to_i)).first
    if @plan.destroy
      redirect_to events_index_path
    else
      flash[:destroy_errors] = @plan.errors.full_messages
      redirect_to "/events/#{@plan.event_id}"
    end
  end
end
