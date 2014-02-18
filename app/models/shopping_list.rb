class ShoppingList < ActiveRecord::Base
  has_many :products, dependent: :destroy
  belongs_to :user

  validates :title, presence: true, uniqueness: true
  validates :date, presence: true
end
