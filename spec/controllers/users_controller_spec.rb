require 'rails_helper'

describe UsersController do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:valid_list) { 'apple milk' }

  context 'Current user is profile owner' do
    before do
      sign_in user
      controller.stub(:current_user).and_return(user)
      controller.stub(:authenticate_user!).and_return(user)
    end

    describe 'GET #show' do
      it 'exposes the requested user' do
        get :show, id: user.to_param
        expect(controller.user).to eq(user)
      end
    end

    describe 'PUT update' do
      it 'updates user' do
        User.any_instance.stub(:save).and_return(true)
        put :update, { id: user.to_param, user: { 'blacklisted_ingredients' => valid_list } }
        expect(response).to redirect_to(user_path(user))
      end

      it 'redirects to user page' do
        put :update, { id: user.to_param, user: { 'blacklisted_ingredients' => valid_list } }
        expect(response).to redirect_to(user_path(user))
      end
    end
  end

  context 'Current user is not profile owner' do
    before do
      sign_in user2
      controller.stub(:current_user).and_return(user2)
      controller.stub(:authenticate_user!).and_return(user2)
    end

    describe 'GET #show' do
      it 'redirects to root page' do
        get :show, id: user.to_param
        expect(response).to redirect_to(root_path)
      end

      it 'renders error message' do
        get :show, id: user.to_param
        expect(controller.flash[:error]).to eq 'Access denied!'
      end
    end

    describe 'PUT update' do
      it 'redirects to root page' do
        put :update, { id: user.to_param, user: { 'blacklisted_ingredients' => valid_list } }
        expect(response).to redirect_to(root_path)
      end

      it 'renders error message' do
        put :update, { id: user.to_param, user: { 'blacklisted_ingredients' => valid_list } }
        expect(controller.flash[:error]).to eq 'Access denied!'
      end
    end
  end
end
