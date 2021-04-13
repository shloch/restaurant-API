Rails.application.routes.draw do
  get 'categories/index'
  # namespace :api do
    # resources :items, only: [:index] 
    get '/items', to: 'items#index'
    get 'items/most_ordered_items', to: 'items#most_ordered_items'
    get 'categories/most_ordered_category', to: 'categories#most_ordered_category'
    get 'orderitems/orders_by_sex', to: 'order_items#orders_by_sex'
  # end
  
  
  
end