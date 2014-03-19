require 'spec_helper'

describe "a user can create a shopping list" do 
  let!(:user_one) { FactoryGirl.create(:user)}
  let!(:households ) do 
    user_one.shopping_lists.create!({
      title: "households",
      date: Date.today
      })
  end

  it "should allow the users to update the name of the list" do 
    login(user_one)
    click_link "View Shopping Lists"
    click_link "households"
    click_link "Change Shopping List Title"
    fill_in "shopping_list_title", with: "Stuff for the House"
    click_button "Click to Update"
    expect(page).to have_content "Stuff for the House"
  end

  it "should render to edit page if title is incomplete" do 
    login(user_one)
    click_link "View Shopping Lists"
    click_link "households"
    click_link "Change Shopping List Title"
    fill_in "shopping_list_title", with: ""
    click_button "Click to Update"
    expect(page).to have_content "Edit List"
  end

  def login(user)
    visit root_path
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    click_button "Login!"
  end
end