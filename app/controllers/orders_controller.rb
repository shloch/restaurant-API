class OrdersController < ApplicationController
    def total_orders
        render json: { results: Order.count }.to_json, status: :ok
    end
end

