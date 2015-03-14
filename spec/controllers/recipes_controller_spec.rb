require 'rails_helper'

describe RecipesController do
  describe 'GET index' do
    context 'all recipes' do
      let(:recipe) { create(:recipe) }

      it 'exposes all recipes' do
        get :index, {}
        expect(controller.recipes).to match_array([recipe])
      end
    end

    context 'search by ingredients' do
      let(:potato_ing) { create(:ingredient, name: 'potato') }
      let(:salt_ing) { create(:ingredient, name: 'salt') }
      let(:bread_ing) { create(:ingredient, name: 'bread') }

      let!(:recipe_1) { create(:recipe, ingredients: [salt_ing, potato_ing]) }
      let!(:recipe_2) { create(:recipe, name: 'recipe', ingredients: [bread_ing]) }

      it 'exposes recipes containing specified ingredients' do
        get :index, ingredients: [salt_ing.id, potato_ing.id]
        expect(controller.recipes).to match_array([recipe_1])
      end
    end
  end
end
