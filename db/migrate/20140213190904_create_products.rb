class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.string :store
      t.integer :shopping_list_id
    end
  end
end
