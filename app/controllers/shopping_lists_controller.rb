class ShoppingListsController < ApplicationController
  before_action :load_user
  before_action :load_shopping_list, only: [:edit, :show, :destroy, :update]


  def index
    @shopping_lists = ShoppingList.all
  end

  def new
    @shopping_list = ShoppingList.new
  end

  def create
    @shopping_list = ShoppingList.create(shopping_params)
    @shopping_list.user = @user
    if @shopping_list.save
      redirect_to user_shopping_lists_path
    else
      render :new
    end
  end

  def search
    render :search
  end

  def edit
    render :edit
  end

  def show
    @products = Product.all
    render :show
  end

  def update
    @changed = @shopping_list.update(shopping_params)

    if @changed
      redirect_to user_shopping_lists_path
    else
      render :edit
    end

  end

  def destroy
  end




private

  def load_user
    @user = User.find(params[:user_id])
  end

  def load_shopping_list
    @shopping_list = @user.shopping_lists.find(params[:id])
  end



  def shopping_params
  params.require(:shopping_list).permit(:title, :date)
  end


end