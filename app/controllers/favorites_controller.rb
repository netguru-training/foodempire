class FavoritesController < ApplicationController
  before_action :set_user, only: [:create, :destroy ]
  

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
    recipe = Recipe.find(params[:recipe_id])
    @favorite = @user.add_to_favorite(recipe.id)

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
    @customer.remove_favorite(@favorite)
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Favorite was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_customer
      @user = current_user
    end
end
