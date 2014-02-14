class ShoppingListsController < ApplicationController
  before_action :load_user

  def index
  end

  def new
    render :new
  end

  def create
    @shopping_list = Shopping_list.create(shopping_params)
    if @shopping_list.save
      redirect_to user_shopping_lists(@user.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end




private

  def load_user
    @user = User.find(params[:user_id])
  end

  def shopping_params
  params.require(:shopping_list).permit(:title, :date)
  end


end