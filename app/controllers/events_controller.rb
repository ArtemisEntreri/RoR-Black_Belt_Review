class EventsController < ApplicationController
  def index
    if session[:user_id].nil?
        redirect_to users_index_path
    else
    	@user = User.find(session[:user_id])
    	@events = Event.all
    	@event = Event.new
        @plans = User.find(session[:user_id]).plans
        @status = ''
    end
  end

  def show
  	@event = Event.select("events.*, users.first_name, users.last_name").joins("LEFT JOIN users ON users.id = events.user_id").where("events.id = ?", params[:id]).first
  	@attendees = Plan.select("plans.*, users.*").joins("LEFT JOIN users ON users.id = plans.user_id").where("plans.event_id = ?", params[:id])
  	@comments = Comment.select("comments.*, users.first_name").joins("LEFT JOIN users ON users.id = comments.user_id").where("comments.event_id = ?", params[:id])
  end

  def create
  	@event = event_params
  	@event[:user_id] = @event[:user_id].to_i
  	@newEvent = Event.create(@event)
  	if @newEvent.save
  		redirect_to events_index_path
  	else
  		flash[:errors] = @newEvent.errors.full_messages
  		redirect_to events_index_path
  	end
  end
  private
  	def event_params
  		params.require(:event).permit(:name, :date, :city, :state, :user_id, :host)
  	end
end