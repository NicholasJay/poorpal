class ProductsController < ApplicationController
  API_KEY = ENV["SEMANTICS_KEY"]
  API_SECRET = ENV["SEMANTICS_SECRET"]
  @sem3 = Semantics3::Products.new(API_KEY, API_SECRET)

  def index
  end

  def new
    @products = find_products("nike")
  end

  def create
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

  def find_products(search_input)
    @sem3.products_field( "name", search_input)
    productsHash = @sem3.get_products
    
    productsHash["results"].each do |hash|
      puts hash["name"] + " - "
      hash["sitedetails"].each do |offers|
        offers["latestoffers"].each do |info|
          print info["seller"] + ": "
          puts info["price"]
          puts
          end
        end
      end
    end
  end

