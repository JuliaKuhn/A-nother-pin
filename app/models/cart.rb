class Cart < ApplicationRecord
  has_many :order_items

  def total_quantity
    @count = 0

    order_items.all.each do |item|
      @count += item.quantity
    end

    @count
  end
end
