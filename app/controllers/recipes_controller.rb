class RecipesController < ApplicationController
  before_action :set_recipe

  def index
    @recipes = Recipe.all.includes(:ingredients).limit(10)
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to @recipe, notice: 'Recipe was successfully created.'
    else
      render action: 'new'
    end
  end

  private
  def set_recipe
    @link = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :recipe_url, :picture_url)
  end
end
