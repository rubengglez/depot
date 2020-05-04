# frozen_string_literal: true

require 'test_helper'

class StoreControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get store_index_url
    assert_response :success
    assert_select 'nav.side_nav a', minimum: 4
    assert_select 'main ul.catalog li', 3
    assert_select 'h2', 'best_product_on_the_world'
    assert_select 'h2', 'second_best_product'
    assert_select '.price', /[,\d]+\.\d\d\s€$/

    assert_equal session[:counter], 1
  end

  test 'when the sotre is visited several times, then the counter should store the times' do
    get store_index_url
    get store_index_url

    assert_equal session[:counter], 2
  end
end
