# frozen_string_literal: true

class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  def add_product(product)
    current_item = line_items.find_by(product_id: product.id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product_id: product.id)
    end
    current_item.price = product.price
    current_item
  end

  def decrementQuantity(line_item_id)
    item = line_items.find(line_item_id)
    item.quantity -= 1
    item.save!
    line_items.delete(item) if item.quantity <= 0
  end

  def total_price
    line_items.to_a.sum(&:total_price)
  end
end
