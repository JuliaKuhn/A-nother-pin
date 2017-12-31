class RenameTypoInOrderItems < ActiveRecord::Migration[5.1]
  def change
    rename_column :order_items, :card_id, :cart_id
  end
end
