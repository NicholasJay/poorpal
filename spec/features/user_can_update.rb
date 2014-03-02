require 'spec_helper'

describe "user can update info" do
  let(:user) { FactoryGirl.create(:user) }

  it "allow a user to update their profile info" do
    # Setup
    visit root_path
    login(user)
    # Workflow for feature
    click_link "Update Profile Information"
    fill_in "user_first_name", with: "Elvis"
    fill_in "user_last_name", with: "Presley"
    fill_in "user_phone_number", with: "8184473002"
    fill_in "user_zipcode", with: "64802"
    click_button "Click to Update"

    # Expectations
    expect(page).to have_content "Elvis"
  end

    it "redirects a user to the edit page if info is not complete" do
    # Setup
    visit root_path
    login(user)
    # Workflow for feature
    click_link "Update Profile Information"
    fill_in "user_password", with: "yolo"
    click_button "Click to Update"

    # Expectations
    expect(page).to have_content "Edit Profile"
  end

  def login(user)
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    click_button "Login!"
  end
end