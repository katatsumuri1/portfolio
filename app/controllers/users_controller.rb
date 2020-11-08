class UsersController < ApplicationController
  def show
  end

  def quit
  end

  def edit
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
end
