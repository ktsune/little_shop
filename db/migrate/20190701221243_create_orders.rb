class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :username
      t.string :shipping_address
      t.integer :quantity
      t.string :subtotal
      t.string :total

      t.timestamps
    end
  end
end
