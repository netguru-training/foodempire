class BlacklistedIngredientsController < ApplicationController
  autocomplete :ingredient, :name
  expose(:blacklisted_ingredients)
  expose(:blacklisted_ingredient)

  def index
  end

  def new
  end

  def create
  end

  private
  def recipe_params
    params.require(:blacklisted_ingredients).permit(:name)
  end
end
