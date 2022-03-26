class ShopsController < ApplicationController
  def index
    shops = Shop.all
      shops = shops.map do |shop|
        { id: shop.id, name: shop.name }
      end
      
      render json: { results: shops }.to_json, status: :ok
  end
end
