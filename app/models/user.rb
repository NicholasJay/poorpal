class User < ActiveRecord::Base
  has_many :shopping_lists
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true
  validates :zipcode, presence: true
  self.has_secure_password()

  def is_admin?
    email == "nicholasjaynovak@gmail.com"
  end

end