class OrderItemsController < ApplicationController

  def orders_by_sex
    itemsHash = { results: []}
    orders = OrderItem.purchases_by_sex
    total_orders = OrderItem.count.to_f

    # female ratio
    ratio_female = orders.first.countOrders/total_orders * 100
    female_percent = {sex: orders.first.sex, numberOrders: orders.first.countOrders, percentage: helper.number_to_percentage(ratio_female, precision: 2), totalOrders: total_orders.to_i}
    itemsHash[:results] << {female: female_percent}

    # male ratio
    ratio_male = orders.last.countOrders/total_orders * 100
    male_percent = {sex: orders.last.sex, numberOrders: orders.last.countOrders, percentage: helper.number_to_percentage(ratio_male, precision: 2), totalOrders: total_orders.to_i}
    itemsHash[:results] << {male: male_percent}

    render json: itemsHash
  end

  def orders_by_city
    itemsHash = { results: []}
    orders = OrderItem.purchases_by_city
  end

  private

  def helper
    @helper ||= Class.new do
      include ActionView::Helpers::NumberHelper
    end.new
  end
end
