# frozen_string_literal: true

Rails.application.routes.draw do
  put '/carts/:id/decrement_amount/:line_item', to: 'carts#decrement_amount'
  resources :line_items
  resources :carts
  root 'store#index', as: 'store_index'
  resources :products

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
