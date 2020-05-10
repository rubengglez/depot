# frozen_string_literal: true

require 'test_helper'

class CartsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cart = carts(:one)
  end

  def create_cart
    post line_items_url, params: { product_id: products(:best_product_on_the_world).id }
  end

  test 'should get index' do
    get carts_url
    assert_response :success
  end

  test 'should get new' do
    get new_cart_url
    assert_response :success
  end

  test 'should create cart' do
    assert_difference('Cart.count') do
      post carts_url, params: { cart: {} }
    end

    assert_redirected_to cart_url(Cart.last)
  end

  test 'should show cart' do
    create_cart
    get cart_url(session[:cart_id])
    assert_response :success
  end

  test 'should get edit' do
    create_cart
    get edit_cart_url(session[:cart_id])
    assert_response :success
  end

  test 'should update cart' do
    create_cart
    patch cart_url(session[:cart_id]), params: { cart: {} }
    assert_redirected_to cart_url(session[:cart_id])
  end

  test 'should destroy cart' do
    post line_items_url, params: { product_id: products(:best_product_on_the_world).id }
    @cart = Cart.find(session[:cart_id])

    assert_difference('Cart.count', -1) do
      delete cart_url(@cart)
    end

    assert_redirected_to store_index_url
  end

  test 'should not access to other carts that is not owner' do
    assert_difference('Cart.count') do
      post carts_url, params: { cart: {} }
    end

    assert_redirected_to cart_url(Cart.last)

    get cart_url(carts(:two))
    assert_redirected_to store_index_url, notice: 'You only can access to your own cart'
  end

  test 'should be possible to decrement the amount of a item in the cart' do
    post line_items_url, params: { product_id: products(:best_product_on_the_world).id }
    post line_items_url, params: { product_id: products(:best_product_on_the_world).id }
    @cart = Cart.find(session[:cart_id])

    assert_equal @cart.line_items[0].quantity, 2
    # TODO: improve
    put "/carts/#{@cart.id}/decrement_amount/#{@cart.line_items[0].id}", xhr: true

    @cart = Cart.find(session[:cart_id])
    assert_equal @cart.line_items[0].quantity, 1

    assert_response :success
  end

  test 'should be possible to delete of item from the cart when when its quantity is 0' do
    post line_items_url, params: { product_id: products(:best_product_on_the_world).id }
    @cart = Cart.find(session[:cart_id])

    assert_equal @cart.line_items[0].quantity, 1
    # TODO: improve
    put "/carts/#{@cart.id}/decrement_amount/#{@cart.line_items[0].id}", xhr: true

    @cart = Cart.find(session[:cart_id])
    assert_equal @cart.line_items.length, 0

    assert_response :success
  end
end
