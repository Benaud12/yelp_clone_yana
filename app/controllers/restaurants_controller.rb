class RestaurantsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @restaurants = Restaurant.all
    @reviews = Review.all
    # raise 'Hello from the Index action'
  end

  def new
    @restaurant = Restaurant.new
  end

  def build_with_user(attributes = {}, user)
    attributes[:user] ||= user
    build(attributes)
  end

  def create
    @restaurant = current_user.restaurants.new(restaurant_params)
    if @restaurant.save
      redirect_to restaurants_path
    else
      render 'new'
    end
  end

  def restaurant_params
    params.require(:restaurant).permit(:name)
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
      @restaurant = Restaurant.find(params[:id])
      @restaurant.update(restaurant_params)
      redirect_to restaurants_path
  end

  def destroy
      @restaurant = Restaurant.find(params[:id])
      if current_user.id == @restaurant.user_id
        @restaurant.destroy
        flash[:notice] = 'Restaurant deleted successfully'
        redirect_to restaurants_path
      else
        redirect_to restaurants_path, alert: "You can't delete other users restaurants"
      end
  end



end
