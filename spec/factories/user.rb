FactoryGirl.define do 
  factory :user do 
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password "nick"
    password_confirmation "nick"
    phone_number "8184473003"
    zipcode 64804
  end

end
