require 'spec_helper'

describe "an admin can view/delete all users" do
  # Here's what I want to do.
  # I want to create a new user that has admin priveledges
  let!(:user_one) { FactoryGirl.create(:user)}
  let!(:user_two) { FactoryGirl.create(:user)}
  let!(:user_three) { FactoryGirl.create(:user)}

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


  it "can only be seen by the admin" do 
  # I want to log in to the website as the 
  # admin and view all of the users that exist on the website.

  login(admin)
  within ".userpage" do 
  click_link "View All Users"
  end

  # should see a list of all the users first names, last names, and emails

  visit users_path
  
  end

  it "cannot be seen by another user" do 
    login(user_one)
    visit user_path(user_one.id)
    expect(page).to_not have_content('View All Users')

  # I then want to log out of the admin user and
  # log in as a random user and try to visit the page
  # where all the users can be viewed. 
  end
  
  # I want to be redirected 
  # to my user page as that user instead of going to a page
  # that shows all of the users if I try to sneak into the all users page
  it "will redirect me back to my user page" do 
    login(user_two)
    visit users_path
  end


  # Would be nice to even have a
  # message that pops up and says. You are not the admin 
  # so you can't go there. Then I want to log out of that user.


  it "deletes a user" do 
  # Then I want to log in as the admin again and view all of the users.
  # I want to be able to see a button next to each user that allows
  # me to delete them. 
  # It would be nice that if I as an admin deleted this user that it would
  # add their email to a blocked list that would not
  # allow them to sign up again with that same email.
  end

  def login(user)
    visit root_path
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    click_button "Login!"
  end



end
