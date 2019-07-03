class RemoveSubtotalFromOrders < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :subtotal, :string
  end
end
