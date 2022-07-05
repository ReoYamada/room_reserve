class ApplicationController < ActionController::Base

  def set_current_user
    @user = User.find(session[:id])
  end

  def authenticate_user
    if @user == nil
      flash[:notice] = "ログインが必要です"
      redirect_to login_path
    end
  end

  def ensure_correct_user
    if session[:id] != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to user_path(@user)
    end
  end

  def set_current_room
    @room = Room.find(params[:id])
  end

  def ensure_correct_room
    if session[:id] != @room.user_id
      flash[:notice] = "権限がありません"
      redirect_to user_path(@user)
    end
  end

  def forbid_login_user
    if session[:id]
      flash[:notice] ="すでにログインしています"
      redirect_to user_path(session[:id])
    end
  end
end
