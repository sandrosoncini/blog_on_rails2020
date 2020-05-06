class UsersController < ApplicationController
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
     @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if  params[:user][:current_password]!= params[:user][:password] && params[:user][:password] == params[:user][:password_confirmation] 
          @user.update(params.require(:user).permit(:password, :password_confirmation))
          redirect_to root_path
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

end
