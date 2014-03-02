require 'spec_helper'

describe "a user cannot go to another users page" do 
  let!(:user_one) { FactoryGirl.create(:user)}
  let!(:user_two) { FactoryGirl.create(:user)}

   it "redirect the user to the main page" do 
    login(user_two)
    visit user_path(user_one.id)
    expect(page).to have_content("Sign Up")
  end

  it "sends user to welcome page when they log out" do 
    login(user_one)
    click_link "Log Out"
    visit user_path(user_one.id)
    expect(page).to have_content("Sign Up")
  end


  def login(user)
    visit root_path
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    click_button "Login!"
  end
end
