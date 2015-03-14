class UsersController < ApplicationController
  expose(:user) { current_user }

  def show
  end

  def update
    flash[:notice] = 'User preferences have been updated' if user.update(user_params)
    redirect_to user_path(user)
  end

  private

  def user_params
    params.require(:user).permit(:blacklisted_ingredients)
  end
end
