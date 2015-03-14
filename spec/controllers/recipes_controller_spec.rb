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
  end
end
