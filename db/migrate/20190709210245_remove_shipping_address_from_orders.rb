class RemoveShippingAddressFromOrders < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :shipping_address, :string
  end
end
