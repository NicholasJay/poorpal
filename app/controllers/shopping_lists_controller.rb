class ShoppingListsController < ApplicationController
  TWIL_ID = ENV["TWIL_SID"]
  TWIL_AUTH = ENV["TWIL_AUTH"]

  before_action :load_user
  before_action :load_shopping_list, only: [:edit, :show, :destroy, :update]


  def index
    @shopping_lists = @user.shopping_lists.all
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

  def edit
    render :edit
  end

  def update
    @changed = @shopping_list.update(shopping_params)

    if @changed
      redirect_to user_shopping_lists_path
    else
      render :edit
    end
  end

  def show
    @products = @shopping_list.products.all
    organize_stores
    render :show
  end

  def destroy
    @list = ShoppingList.find(params[:id])
    @list.destroy
    redirect_to user_shopping_lists_path
  end




private

  def load_user
    @user = User.find(params[:user_id])
  end

  def load_shopping_list
    @shopping_list = @user.shopping_lists.find(params[:id])
  end

  def organize_stores
    @stores = []
    @products.each {|store| @stores << store[:store]}
    @stores.uniq!
  end

  def shopping_params
    params.require(:shopping_list).permit(:title, :date)
  end


end