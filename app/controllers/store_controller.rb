# frozen_string_literal: true

class StoreController < ApplicationController
  def index
    @products = Product.order(:title)
    session[:counter] = 0 unless session[:counter]
    session[:counter] += 1
    @visits = session[:counter]
  end
end
