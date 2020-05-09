class UsersController < ApplicationController
  before_action :authorize!, only: [:edit, :update, :change_password]
  
  def new
      @user = User.new
  end

  def create

    @user = User.new params.require(:user).permit(:name, :email, :password, :password_confirmation)
      if @user.save  
          redirect_to root_path 
      else
          flash[:warning] = "Unable to create user,please try again" 
          render :new 
	  end
  end

  def edit
     @user = User.find(params[:id])# @user User.find session[:user_id]
     # # the current_user method already fetches the logged in user for us
    end

  def update
  
      @user = User.find params[:id]
      if (current_user.authenticate(params[:user][:current_password]))
          if params[:user][:current_password]!= params[:user][:password] && params[:user][:password] == params[:user][:password_confirmation] 
                @user.update(params.require(:user).permit(:password, :password_confirmation))
                redirect_to root_path
          end
      elsif @user.update(params.require(:user).permit(:name, :email))
          redirect_to root_path
      else
          flash[:warning] = "Unable to change password" 
          render :change_password  
      end
     
      
  end

  def change_password
    @user = User.find(params[:id])
  end

  private

    def authorize! 
        @user= User.find(params[:id])
        redirect_to root_path, alert: 'Not Authorized' unless can?(:crud, @user)
    end

end


