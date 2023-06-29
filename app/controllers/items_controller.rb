class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  before_action :find_user
  def index
    user = User.find(params[:user_id])
    items = user.items
    # items = Item.all  
    render json: items, include: :user
  end

  def show
    item = Item.find_by(id: params[:id])
    render json: item.to_json
  end

  def create
    item =Item.create(items_params)
    render json: item, status: :created
  end

  private
  def render_not_found
    render json: {error: "Items not found"}, status: :not_found
  end

  def items_params
    params.permit(:name, :description, :price, :user_id)
  end

  def find_user
    user = User.find(params[:user_id])
  end

end
