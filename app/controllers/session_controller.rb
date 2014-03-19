class SessionController < ApplicationController

  def index
  end

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    
    if user && (user.authenticate(params[:password]))
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      flash[:error] = "Username or Password not found!"
      redirect_to new_user_path
    end 

  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end