class UsersController < ApplicationController

  before_action :set_current_user, {only:[:show, :edit, :update]}
  before_action :authenticate_user, {only: [:show, :edit, :update]}
  before_action :ensure_correct_user,{only: [:edit, :update]}
  before_action :forbid_login_user, {only: [:login, :login_form, :new, :create]}
  def index
  end

  def show
  end

  def new
    @user = User.new
  end
    
  def create
    @user = User.new(user_params)
    if @user.save(content: :password_change)
      session[:id] = @user.id
      flash[:notice] = "アカウントを作成しました"
      redirect_to user_path(session[:id])
    else
      flash[:error_message] = @user.errors.full_messages
      flash[:name] = @user.name
      flash[:email] = @user.email
      flash[:password] = @user.password
      redirect_to new_user_path
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "変更しました"
      redirect_to user_path(session[:id])
    else
      render "edit"
    end
  end

  def login_form
  end

  def login
    @user = User.find_by(email: params[:email])

    if @user&.authenticate(params[:password])
      flash[:notice] = "ログインしました"
      session[:id] = @user.id
      redirect_to user_path(session[:id])
    else
      @email = params[:email]
      @password = params[:password]
      @error_message = "メールアドレスまたはパスワードが間違っています"
      render "login_form"
    end
  end

  def logout
    session[:id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to "/"
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :introduction, :user_image)
  end
end
