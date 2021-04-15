class CategoriesController < ApplicationController
  def index
  end

  # most ordered Category
  def most_ordered_category
    itemsHash = { results: []}
    orders = OrderItem.most_ordered_5_items
    category = Category.find(Item.where('id' => orders.first.item_id)[0].category_id)
    if category
      itemsHash[:results] << {category: category.cat_name}
      render json: itemsHash
    else
      render json: { message: 'Category not found' }
    end
  end

  
end
