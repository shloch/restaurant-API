module Api
  class ItemsController < ApplicationController
    def index
      items = Item.all
      items = items.map do |item|
        { id: item.id, name: item.name, price: item.price }
      end
      
      render json: { results: items }.to_json, status: :ok
    end
  end
end
