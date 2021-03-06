class UsersController < ApplicationController
  before_action :load_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate, :authorize, only: [:edit, :show]

  def index
    if current_user.is_admin?
    @users = User.all
    else
      redirect_to user_path(current_user.id)
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render :new
    end
    
  end

  def show
    render :show
  end

  def edit
    render :edit
  end

  def update
    @changed = @user.update(user_params)

    if @changed
      redirect_to user_path(@user.id)
    else
      render :edit
    end

  end

  def destroy
  end


  private

  def load_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone_number, :street_address, :city, :state, :zipcode, :password, :password_confirmation)
  end

  def authenticate
    unless logged_in?
      redirect_to root_path
    end
  end

  def authorize
    unless current_user == @user
      redirect_to root_path
    end
  end

end