Rails.application.routes.draw do
    get 'categories/index'
  # namespace :api do
    # resources :items, only: [:index] 
    get '/clients/total_clients', to: 'clients#total_clients'
    get '/orders/total_orders', to: 'orders#total_orders'

    get '/items', to: 'items#index'
    get '/items/most_ordered_items', to: 'items#most_ordered_items'

    get '/categories', to: 'categories#index'
    get '/categories/most_ordered_category', to: 'categories#most_ordered_category'

    get '/orderitems', to: 'order_items#index'
    get '/orderitems/orders_by_sex', to: 'order_items#orders_by_sex'
    get '/orderitems/orders_by_city', to: 'order_items#orders_by_city'
    get '/orderitems/highest_spender', to: 'order_items#highest_spender'
    get 'orderitems/spending_amounts_by_age_group', to: 'order_items#spending_amounts_by_age_group'
    get 'orderitems/volume_orders_by_age_group', to: 'order_items#volume_orders_by_age_group'
  
  # end  
  
end