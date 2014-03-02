require 'spec_helper'
describe User do
  it { should have_many(:shopping_lists) }
  
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:phone_number) }
  it { should validate_presence_of(:zipcode) }

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
  
  let!(:user_one) { FactoryGirl.create(:user) }


  it "should show that admin - Nicholas is true" do 
    expect(admin.is_admin?).to be_true
  end

  it "should show that user_one is not an admin" do 
    expect(user_one.is_admin?).to be_false
  end

end
