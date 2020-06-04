# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :line_items
  before_destroy :ensure_not_referenced_by_any_line_item
  has_many :orders, through: :line_items

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

  private

  # ensure that there are no line items referencing this product
  def ensure_not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, 'Line Items present')
      throw :abort
    end
  end
end
