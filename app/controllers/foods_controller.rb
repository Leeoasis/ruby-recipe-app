class FoodsController < ApplicationController
  before_action :authenticate_user!

  def index
    @foods = current_user.foods
  end

  def new
    @food = current_user.foods.new
  end

  def create
    @food = current_user.foods.new(food_params)
    if @food.save
      redirect_to foods_path, notice: 'Food was successfully created.'
    else
      render :new
    end
  end

  def edit
    @food = current_user.foods.find(params[:id])
  end

  def update
    @food = current_user.foods.find(params[:id])
    if @food.update(food_params)
      redirect_to foods_path, notice: 'Food was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @food = current_user.foods.find(params[:id])
    @food.destroy
    redirect_to foods_path, notice: 'Food was successfully deleted.'
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
