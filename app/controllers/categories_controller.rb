class CategoriesController < ApplicationController
  before_action :verify_shop, only: [:most_ordered_category]
  
  def index
    categories = Category.all
    categories = categories.map do |c|
      { id: c.id, name: c.cat_name}
    end
    
    render json: { results: categories }.to_json, status: :ok
  end

  # most ordered Category
  def most_ordered_category
    itemsHash = { results: []}
    orders = OrderItem.where('shop_id' => @shopID).most_ordered_5_items
    category = Category.find(Item.where('id' => orders.first.item_id)[0].category_id)
    if category
      itemsHash[:results] << {category: category.cat_name}
      render json: itemsHash
    else
      render json: { message: 'Category not found' }
    end
  end


end
