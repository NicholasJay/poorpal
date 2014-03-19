require 'spec_helper'

describe "a user can create a shopping list" do 
  let!(:user_one) { FactoryGirl.create(:user)}
  let!(:households ) do 
    user_one.shopping_lists.create!({
      title: "households",
      date: Date.today
      })
  end
  let!(:product ) do
    households.products.create!({
      name: "Crest 3DWhite",
      store: "Walmart",
      price: "5"
      })
  end

  it "should delete an item on the list" do 
    login(user_one)
    click_link "View Shopping Lists"
    click_link "households"
    first(:button, "Delete").click
    expect(page).to_not have_content "3DWhite"
  end

  def login(user)
    visit root_path
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    click_button "Login!"
  end
end