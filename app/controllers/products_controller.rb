class ProductsController < ApplicationController
  API_KEY = ENV["SEMANTICS_KEY"]
  API_SECRET = ENV["SEMANTICS_SECRET"]

  before_action :load_user
  before_action :load_shopping_list

  def index
    render :index
  end

  def new
    @product = Product.new
  end

  def show
    @products = product_find(params[:search_input])
  end

  def create
    @product = Product.new(name: params[:name], price: params[:price], store: params[:store])
  end

  def destroy
  end


private

  def load_user
    @user = User.find(params[:user_id])
  end

  def load_shopping_list
    @shopping_list = ShoppingList.find(params[:shopping_list_id])
  end

  def load_product
    @product = Product.find(params[:id])
  end

  def product_find(item)
    @items = []
    @sem3 = Semantics3::Products.new(API_KEY, API_SECRET)
    @sem3.products_field( "name", item )
    productsHash = @sem3.get_products

    productsHash["results"].each do |hash|
      hash["sitedetails"].each do |offers|
        offers["latestoffers"].each do |info|
          @items << {item: hash["name"], seller: info["seller"], price: info["price"]}
        end
      end
    end
  end

  def product_params
    params.require(:product).permit(:name, :price, :store)
  end

end

