class RecipesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @recipes = current_user.recipes
  end

  def show
    @recipe = Recipe.find(params[:id])
  
    if @recipe.public? || @recipe.user == current_user
      authorize! :read, @recipe
      @foods = @recipe.foods
    else
      flash[:alert] = "You are not authorized to access this recipe."
      redirect_to root_path
    end
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

  def toggle
    @recipe = current_user.recipes.find(params[:id])
    @recipe.update(public: !@recipe.public)
    redirect_to recipe_path(@recipe), notice: 'Recipe visibility toggled successfully.'
  end

  def public_list
    @public_recipes = Recipe.where(public: true).order(created_at: :desc)
  end

  def destroy
    @recipe = current_user.recipes.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path, notice: 'Recipe was successfully deleted.'
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
