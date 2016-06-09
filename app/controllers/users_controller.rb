class UsersController < ApplicationController
  
    def index
        if !session[:user_id].nil?
            redirect_to events_index_path
        end
    	@user = User.new
    end

    def login
    end

    def register
    	@user = User.create(user_params)
    	if @user.save
    		session[:user_id] = @user.id
    		redirect_to events_index_path
    	else
    		flash[:errors] = @user.errors.full_messages
    		redirect_to users_index_path
    	end
    end

    def edit
        @user = User.find(session[:user_id])
    end

    def update
        @user = User.find(session[:user_id])
        if @user.update_attributes(user_params)
            redirect_to events_index_path
        else  
            flash[:errors] = @user.errors.full_messages
            redirect_to "/users/edit"
        end
    end

    private
    	def user_params
    		params.require(:user).permit(:first_name, :last_name, :email, :city, :state, :password)
    	end	
end
