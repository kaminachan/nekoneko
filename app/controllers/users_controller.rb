class UsersController < ApplicationController
  before_action :authenticate_user, only: [:show, :edit]

  def update_time
    @time = Time.now.to_s
  end

  def ajax_result

  end

  def index

  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    #log_in @user
    unless session[:user_id] == @user.id
      redirect_to user_path(session[:user_id])
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "さあ、単語帳を始めましょう！"
      redirect_to user_path(id: @user.id)
    else
      flash.now[:danger] = 'ユーザーの登録に失敗しました。'
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    if session[:user_id] == @user.id
      request.fullpath
    else
      redirect_to edit_user_path(session[:user_id])
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "更新しました"
      redirect_to user_path(params[:id])
    else
      render 'edit'
    end
  end


  private
  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
end

