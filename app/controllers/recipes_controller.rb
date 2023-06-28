class RecipesController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.recipes.empty?
      redirect_to new_recipe_path
    else
      @recipes = current_user.recipes.all
    end
  end
  
  def show
    @recipe = current_user.recipes.find(params[:id])
    @foods = @recipe.foods
  end

  def new
    @recipe = current_user.recipes.new
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    if @recipe.save
      redirect_to recipes_path, notice: 'Recipe was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @recipe = current_user.recipes.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path, notice: 'Recipe was successfully deleted.'
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :description, :public)
  end
end
