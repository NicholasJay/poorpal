class ProductsController < ApplicationController
  API_KEY = ENV["SEMANTICS_KEY"]
  API_SECRET = ENV["SEMANTICS_SECRET"]
  TWIL_ID = ENV["TWIL_SID"]
  TWIL_AUTH = ENV["TWIL_AUTH"]


  before_action :load_user
  before_action :load_shopping_list

  def index
    @products = @shopping_list.products.all
    organize_stores
    render :index
  end

  def sendtext
    send_text_message
    render :sendtext
  end

  def new
    send_text_message
  end

  def show
    @products = product_find(params[:search_input])
    @products.sort_by! {|item| item[:price].to_f}

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

def send_text_message
    @products = @shopping_list.products.all
    @list = @shopping_list.products.all
    @final = @list.map {|item| item.name}

    @allinfo = []

    organize_stores
    def organized
      @stores.each do |store|
        @products.each do |item|
          if item.store == store
            @allinfo << store
            @allinfo << item.name
          end
        end
      end
    end
    organized



    twilio_sid = TWIL_ID
    twilio_token = TWIL_AUTH
 
    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
 
    @twilio_client.account.sms.messages.create(
      :from => "+17472013048",
      :to => "+1#{@user.phone_number}",
      :body => "#{@allinfo}"
    )
end

  def organize_stores
    @stores = []
    @products.each {|store| @stores << store[:store]}
    @stores.uniq!
  end

  def product_params
    params.require(:product).permit(:name, :price, :store, :shopping_list_id)
  end

end

