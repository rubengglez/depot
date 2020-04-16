# frozen_string_literal: true

require 'test_helper'

class StoreHelperTest < ActionView::TestCase
  test 'should return the price in euros' do
    euros = toEuros(1)

    assert_equal euros, '1.00 €'
  end
end
