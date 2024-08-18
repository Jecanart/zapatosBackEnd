class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :product_name
      t.float :product_price
      t.integer :stock
      t.integer :discount
      t.string :brand
      t.string :main_img

      t.timestamps
    end
  end
end
