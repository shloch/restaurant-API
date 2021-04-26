# module Api
  class ItemsController < ApplicationController
    def index
      items = Item.all
      items = items.map do |item|
        { id: item.id, name: item.name, price: item.price }
      end
      
      render json: { results: items }.to_json, status: :ok
    end


    # 5 most order items
    def most_ordered_items
      itemsHash = { results: []}
      orders = OrderItem.most_ordered_5_items
      orders.each_with_index do |o, idx|
        item = Item.find(o.item_id)
        itemsHash[:results] << {id: idx+1, item: item.name, price: item.price, numberOfOrders: o.countCommands}
      end
      render json: itemsHash
    end

   
  end
# end
