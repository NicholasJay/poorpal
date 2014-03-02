require 'spec_helper'

describe "a user can send a shopping list to their email" do 
  let!(:user_one) { FactoryGirl.create(:user)}
  let!(:households ) do 
    user_one.shopping_lists.create!({
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

  it "will send an email of the list on the current page" do 
    login(user_one)
    click_link "View Shopping Lists"
    click_link "households"
    click_link "Send List to Email"
    expect(page).to have_content("Message Emailed")
  end


  def login(user)
    visit root_path
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    click_button "Login!"
  end
end