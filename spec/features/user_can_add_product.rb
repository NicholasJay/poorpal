require 'spec_helper'

describe "a user can add a product to their shopping list" do 
  let!(:user_one) { FactoryGirl.create(:user) }
  let!(:households) do 
    user_one.shopping_lists.create!({
      title: "households",
      date: Date.today
      })
  end

  it "will add product to the list" do 
    login(user_one)
    click_link "View Shopping Lists"
    click_link "households"
    fill_in :search_input, with: "clorox"
    click_button "submit_search"
    # find_button("Search").trigger('click')
    # save_and_open_page

    # first(:button, "Add Item").click

    expect(page).to have_content "clorox"
  end

  def login(user)
    visit root_path
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    click_button "Login!"
  end

end
