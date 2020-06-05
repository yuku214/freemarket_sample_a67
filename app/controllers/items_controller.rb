class ItemsController < ApplicationController

before_action :set_parents, only:[:show]

def new
  @item = Item.new
  @item.item_images.new
  @category_parent_array = Category.where(ancestry: nil)
end

def create
  @item = Item.new(item_params)
  if @item.save
    redirect_to root_path
  else
    render :new
  end
end

def show
  @item = Item.find(params[:id])
  @category = @item.category
end


def get_category_children
  @category_children = Category.find(params[:parent_id]).children
end

def get_category_grandchildren
  @category_grandchildren = Category.find(params[:child_id]).children
end

private
def item_params
  params.require(:item).permit(:items_name,
      :item_description,
      :condition,
      :shipping_costs,
      :days_to_ship,
      :price,
      :category_id,
      :brand_id,
      :prefecture_id,
      item_images_attributes: [:image_URL,:_destroy, :id]).merge(user_id: current_user.id)
end

def set_parents
  @parents = Category.where(ancestry: nil)
end

end
