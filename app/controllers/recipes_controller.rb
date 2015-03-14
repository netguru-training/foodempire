class RecipesController < ApplicationController
  autocomplete :ingredient, :name
  expose(:recipe)
  expose(:recipes)
#skladniki - params[:ingredients]
  def index
    self.recipes = Recipe.all.includes(:ingredients).limit(10)
    gon.ingredients = Ingredient.all.map(&:name)
    
  end

  def new
  end

  def create
    self.recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to @recipe, notice: 'Recipe was successfully created.'
    else
      render action: 'new'
    end
  end

  private
  def recipe_params
    params.require(:recipe).permit(:name, :recipe_url, :picture_url)
  end
end
