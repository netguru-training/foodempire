class FavoritesController < ApplicationController

  expose(:recipes)
  expose(:recipe)
  expose(:favorites_hash){
    hash={}
    current_user.favorites.each do |f|
      hash[f.recipe_id] = f.id
    end
    hash
  }
  # GET /favorites
  # GET /favorites.json
  def index
    if user_signed_in?
      @favorites = current_user.favorites

    end
  end

  # POST /favorites
  # POST /favorites.json
  def create
    recipe = Recipe.find(params[:id])
    @favorite = current_user.add_to_favorite(recipe.id)

    respond_to do |format|
      if @favorite.save
        format.html { redirect_to :back, notice: 'Favorite was successfully created.' }
        format.json { render :show, status: :created, location: @favorite }
      else
        format.html { render :new }
        format.json { render json: @favorite.errors, status: :unprocessable_entity }
      end
    end
  end



  # DELETE /favorites/1
  # DELETE /favorites/1.json
  def destroy
    favorite = Favorite.find(params[:id])
    favorite.destroy
    redirect_to :back
  end



end
