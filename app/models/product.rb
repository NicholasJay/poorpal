class Product < ActiveRecord::Base
  belongs_to :shopping_list

  validates :store, presence: true
  validates :price, presence: true
  validate :name, presence: true

  
end