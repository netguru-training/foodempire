class RecipesController < ApplicationController
  expose(:recipe)
  expose(:recipes)
  expose(:favorites_hash) {
    hash={}
    current_user.favorites.each do |f|
      hash[f.recipe_id] = f.id
    end
    hash
  }

  def index
    if user_signed_in?
      if params[:ingredients].present?
        current_user.update(ingredients_ids: params[:ingredients])
      end
      ingredients = current_user.ingredients
    else
      ingredients = []
    end

    if params[:ingredients].present?
      ingredients_ids = params[:ingredients] + ingredients.map(&:id)
      self.recipes = RecipeFinder.new(ingredients_ids, current_user).search
    elsif ingredients.present?
      self.recipes = RecipeFinder.new(ingredients.map(&:id), current_user).search
    else
      self.recipes = Recipe.without_blacklist(current_user).includes(:ingredients).limit(10)
    end

    gon.my_ingredients = ingredients.map(&:name)
    gon.ingredients = Ingredient.all.map { |i| { value: i.id, label: i.name } }
    gon.favourites = user_signed_in? ? favorites_hash : {}

    respond_to do |format|
      format.html
      format.json { render json: self.recipes.to_json(:include => :ingredients) }
    end
  end

  def new
  end

  def create
    self.recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to recipe, notice: 'Recipe was successfully created.'
    else
      render action: 'new'
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :recipe_url, :picture_url)
  end
end
