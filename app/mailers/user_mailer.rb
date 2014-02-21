class UserMailer < ActionMailer::Base
  default from: "poorpalweb@gmail.com"


  def send_list(user, shopping_list, products, stores)
    @user = user
    @shopping_list = shopping_list
    @products = products
    @stores = stores
    mail(to: @user.email, subject: "Your Shopping List")
  end

end
