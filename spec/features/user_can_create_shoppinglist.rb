require 'spec_helper'

describe "a user can create a shopping list" do 
  let!(:user_one) { FactoryGirl.create(:user)}

  it "should create a new list called Bathroom Stuff" do 
  #setup
  visit root_path
  login(user_one)

  #Workflow
  click_link "Create New Shopping List"
  fill_in "shopping_list_title", with: "Bathroom Stuff"
  click_button "Create Shopping list"
  expect(page).to have_content "Bathroom Stuff"
  end

  it "will render to the new page if list wasn't created" do 
  #setup
  visit root_path
  login(user_one)

  #Workflow
  click_link "Create New Shopping List"
  click_button "Create Shopping list"
  expect(page).to have_content "New List"
  end


  def login(user)
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    click_button "Login!"
  end
end

