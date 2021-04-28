class OrderItemsController < ApplicationController
  before_action :get_total_orders, only: [:orders_by_sex, :orders_by_city]
  before_action :get_total_spent, only: [:spending_amounts_by_age_group]

  def index
    render json: { results: OrderItem.count }.to_json, status: :ok
  end

  def orders_by_sex
    itemsHash = { results: []}
    orders = OrderItem.purchases_by_sex

    # female ratio
    ratio_female = orders.first.countOrders/@total_orders * 100
    female_percent = {sex: orders.first.sex, numberOrders: orders.first.countOrders, percentage: helper.number_to_percentage(ratio_female, precision: 2), totalOrders: @total_orders.to_i}
    itemsHash[:results] << female_percent

    # male ratio
    ratio_male = orders.last.countOrders/@total_orders * 100
    male_percent = {sex: orders.last.sex, numberOrders: orders.last.countOrders, percentage: helper.number_to_percentage(ratio_male, precision: 2), totalOrders: @total_orders.to_i}
    itemsHash[:results] << male_percent

    render json: itemsHash
  end

  # classify spending by cities
  def orders_by_city
    itemsHash = { results: []}
    orders = OrderItem.purchases_by_city
    if orders.size
      orders.each do |o|
        percentage = o.countOrders/@total_orders * 100
        itemsHash[:results] << {city: o.city, numberOrders: o.countOrders, percentage: helper.number_to_percentage(percentage, precision: 2), totalOrders: @total_orders.to_i}
      end
      render json: itemsHash
    else
      render json: { message: 'orders not found' }
    end
  end

  # returns client that spent most in one purchase + amount
  def highest_spender
    itemsHash = { results: []}
    spender = OrderItem.highest_spender
    itemsHash[:results] << {client_name: spender[:clientObj].name, sex: spender[:clientObj].sex, mobile:spender[:clientObj].mobile, amount: spender[:price]}
    render json: itemsHash
  end

  # most spending age group (sum oney spent by each group)
  # 0-26 [Adolescence]
  # 27-35 [Youths]
  # 35-   [adults]
  def spending_amounts_by_age_group
    itemsHash = { results: []}
    orders = OrderItem.spending_by_age_group
    total_orders = OrderItem.count
    orders.keys.each do |age_group|
      percentage = orders[age_group]/@total_spent * 100
      itemsHash[:results] << {age_group: age_group, amount: orders[age_group], total_orders: total_orders, percentage: helper.number_to_percentage(percentage, precision: 2)}
    end
    render json: itemsHash
  end

  # clasfication of orders by each group
  # def volume_orders_by_age_group
  #   itemsHash = { results: []}
  #   orders = OrderItem.order_counts_by_age_group
  #   orders.each do |o|
  #     percentage = o.countOrders/@total_orders * 100
  #     itemsHash[:results] << {age_group: o.age_group, numberOrders: o.countOrders, percentage: helper.number_to_percentage(percentage, precision: 2), totalOrders: @total_orders.to_i}
  #   render json: itemsHash
  # end 

  private

  def helper
    @helper ||= Class.new do
      include ActionView::Helpers::NumberHelper
    end.new
  end

  def get_total_orders
    @total_orders = OrderItem.count.to_f
  end

  def get_total_spent
    @total_spent = OrderItem.total_spent.to_f
  end

end
