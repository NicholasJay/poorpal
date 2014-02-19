class UserMailer < ActionMailer::Base
  default from: "from@example.com"


  def send_list
    @user = User.find(params[:user_id])
    @shopping_list = ShoppingList.find(params[:shopping_list_id])
    @products = @shopping_list.products.all

    organize_stores

    @url = new_user_shopping_list_product_path(@user.id, @shopping_list.id)
    mail(to: @user.email, subject: "Your Shopping List")
  end

  def organize_stores
      @stores = []
      @products.each {|store| @stores << store[:store]}
      @stores.uniq!
  end

end
