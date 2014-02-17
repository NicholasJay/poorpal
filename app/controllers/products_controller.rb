class ProductsController < ApplicationController
  API_KEY = ENV["SEMANTICS_KEY"]
  API_SECRET = ENV["SEMANTICS_SECRET"]

  before_action :load_user
  before_action :load_shopping_list

  def index
    @products = @shopping_list.products.all
    render :index
  end

  def new
    @product = Product.new
  end

  def show
    @products = product_find(params[:search_input])
    @products.sort_by! {|item| item[:price].to_i}
    if @products.empty?
      @message = "Product Not Found"
    else
      @message = "Click Add to put item in your shopping list"
    end
  end

  def create
    @product = Product.create(name: params[:name], price: params[:price], store: params[:store], shopping_list_id: params[:shopping_list_id])
    if @product
      redirect_to user_shopping_list_products_path(@user.id, @shopping_list.id)
    else
      redirect_to :new
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to user_shopping_list_products_path(@user.id, @shopping_list.id)
  end


private

  def load_user
    @user = User.find(params[:user_id])
  end

  def load_shopping_list
    @shopping_list = ShoppingList.find(params[:shopping_list_id])
  end

  def product_find(item)
    items = []
    @sem3 = Semantics3::Products.new(API_KEY, API_SECRET)
    @sem3.products_field( "name", item )
    productsHash = @sem3.get_products

      productsHash["results"].each do |hash|
        if hash["sitedetails"]
          hash["sitedetails"].each do |offers|
            offers["latestoffers"].each do |info|
              items << {item: hash["name"], seller: info["seller"], price: info["price"]}
            end
          end
        end
      end

    return items
  
  end

  def product_params
    params.require(:product).permit(:name, :price, :store, :shopping_list_id)
  end

end

