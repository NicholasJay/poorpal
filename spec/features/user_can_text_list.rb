require 'spec_helper'

describe "a user can send a shopping list to their email" do 
  let!(:admin) do 
    User.create!({
    email: "nicholasjaynovak@gmail.com",
    first_name: "Nicholas",
    last_name: "Admin",
    password: "nicholas",
    password_confirmation: "nicholas",
    phone_number: 8184473005,
    zipcode: 10031
  })
  end

  let!(:households ) do 
    admin.shopping_lists.create!({
      title: "households",
      date: Date.today
      })
  end

  let!(:toothpaste) do 
    households.products.create!({
      name: "toothpaste",
      price: "5",
      store: "Target"
      })
  end

  it "will send a text of the list on the current page" do 
    login(admin)
    click_link "View Shopping Lists"
    click_link "households"
    click_link "Send to Phone"
    expect(page).to have_content("Message Sent")
  end


  def login(user)
    visit root_path
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    click_button "Login!"
  end
end