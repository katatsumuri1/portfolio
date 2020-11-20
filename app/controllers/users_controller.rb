class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.order(created_at: "DESC")
  end

  def quit
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user= User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
    
  end
  def out
    @user = current_user
    @user.update(is_deleted: "Invalid")
    reset_session
    flash[:notice]= "退会完了致しました。"
    redirect_to root_path
  end

  def following
  end

  def followers
  end
  
  private
  
  def user_params
  params.require(:user).permit(:name, :profile, :email, :image)
  end
end
