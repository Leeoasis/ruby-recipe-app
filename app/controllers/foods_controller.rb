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

  def shopping_list
    @recipe = Recipe.find(params[:id])
    return unless @recipe

    @recipe_foods = @recipe.recipe_foods.includes(:food)

    @shopping_list = @recipe_foods.map do |recipe_food|
      food = recipe_food.food
      quantity = recipe_food.quantity
      value = quantity * food.price

      {
        food:,
        quantity:,
        value:
      }
    end

    @total_food_items = @shopping_list.length
    @total = @shopping_list.sum { |item| item[:value] }
  end

  def destroy
    @food = current_user.foods.find(params[:id])
    @food.destroy
    redirect_to foods_path, notice: 'Food was successfully deleted.'
  end

  def shopping_list
    @recipe = Recipe.find(params[:id])
    return unless @recipe

    @recipe_foods = @recipe.recipe_foods.includes(:food)

    @shopping_list = @recipe_foods.map do |recipe_food|
      food = recipe_food.food
      measurement_unit = food.measurement_unit
      quantity = recipe_food.quantity
      value = quantity * food.price

      {
        food:,
        measurement_unit:,
        quantity:,
        value:
      }
    end

    @total_food_items = @shopping_list.length
    @total = @shopping_list.sum { |item| item[:value] }
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
