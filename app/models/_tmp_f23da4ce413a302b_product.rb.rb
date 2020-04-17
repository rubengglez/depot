# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :line_items
  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :description, :image_url, presence: true
  validates :price, numericality: {
    greater_than_or_equal_to: 1.0,
    message: 'price should be greater than or equal to 1.0'
  }
  validates :image_url, allow_blank: false, format: {
    with: /\.(gif|jpg|png|jpeg)\Z/i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }
  validates :title, uniqueness: true, length: { minimum: 10 }

  module CurrentCart
  private

    def set_cart
      @cart = Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end
end
end
