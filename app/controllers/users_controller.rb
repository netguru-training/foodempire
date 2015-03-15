class UsersController < ApplicationController
  before_action :authenticate_user!
  before_filter :require_permission
  expose(:user) { User.find(params[:id]) }

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

  def require_permission
    if current_user != user
      redirect_to root_path
      flash[:error] = 'Access denied!'
    end
  end
end
