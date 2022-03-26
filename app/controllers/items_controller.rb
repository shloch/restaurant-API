# module Api
  class ItemsController < ApplicationController
    before_action :verify_shop

    def index
      
      shop_items = ItemsShop.where('shop_id' => @shopID).select('item_id').to_a

      items = []
      shop_items.each { |i|
        item = Item.find(i.item_id)
        items << { id: item.id, name: item.name, price: item.price }
      }
      render json: items
    end


    # 5 most order items
    def most_ordered_items
      itemsHash = { results: []}
      orders = OrderItem.where('shop_id' => @shopID).most_ordered_5_items
      orders.each_with_index do |o, idx|
        item = Item.find(o.item_id)
        itemsHash[:results] << {id: idx+1, itemName: item.name, price: item.price, numberOfOrders: o.countCommands}
      end
      render json: itemsHash
    end

 
  end
