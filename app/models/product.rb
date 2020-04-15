class Product < ApplicationRecord
  validates :title, :description, :image_url, presence: true
  validates :price, numericality: {
            greater_than_or_equal_to: 1.0,
            message: "price should be greater than or equal to 1.0",
          }
  validates :image_url, allow_blank: false, format: {
                          with: %r{\.(gif|jpg|png|jpeg)\Z}i,
                          message: "must be a URL for GIF, JPG or PNG image.",
                        }
  validates :title, uniqueness: true, length: { minimum: 10 }
end
