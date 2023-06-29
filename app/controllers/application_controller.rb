class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :configure_permitted_parameters, if: :devise_controller?
  before_action :current_user

  def shopping_list
    @recipe = Recipe.find(params[:id])
    return unless @recipe
  
    @recipe_foods = @recipe.recipe_foods.includes(:food)
  
    @shopping_list = @recipe_foods.map do |recipe_food|
      food = recipe_food.food
      quantity = recipe_food.quantity
      value = quantity * food.price
  
      {
        food: food,
        quantity: quantity,
        value: value
      }
    end
  
    @total_food_items = @shopping_list.length
    @total = @shopping_list.sum { |item| item[:value] }
  end 

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
