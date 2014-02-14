class CreateShoppingLists < ActiveRecord::Migration
  def change
    create_table :shopping_lists do |t|
      t.string :title
      t.date :date
      t.integer :user_id
    end
  end
end
