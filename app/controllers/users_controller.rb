class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.order(created_at: 'DESC')
  end

  def quit; end

  def edit
    @user = User.find(params[:id])
    redirect_to user_path(current_user) if @user != current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = '登録情報を更新しました'
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def out
    @user = current_user
    @user.update(is_deleted: 'Invalid')
    reset_session
    redirect_to root_path
  end

  def following; end

  def followers; end

  private

  def user_params
    params.require(:user).permit(:name, :profile, :email, :image)
  end
end
