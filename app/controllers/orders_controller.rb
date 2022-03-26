class OrdersController < ApplicationController
    before_action :verify_shop

    def total_orders
        render json: { results: Order.where('shop_id' => @shopID).count }.to_json, status: :ok
    end
end

