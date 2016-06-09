class CommentsController < ApplicationController
  def create
  	@comment = Comment.new(content: params[:content], user_id: params[:user_id].to_i, event_id: params[:event_id].to_i)
  	# render :json => @comment
  	if @comment.save
  		redirect_to "/events/#{@comment.event_id}"
  	else
  		flash[:comment_errors] = @comment.errors.full_messages
  		redirect_to "/events/#{@comment.event_id}"
  	end
  end
end
