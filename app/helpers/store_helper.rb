# frozen_string_literal: true

module StoreHelper
  def toEuros(price)
    number_to_currency(price, {
                         format: '%n %u',
                         unit: '€'
                       })
  end
end
