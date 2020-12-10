class SessionsController < ApplicationController

  def new

  end

  def create
    @user = User.find_by(name: params[:session][:name].downcase)
      #ユーザーとパスワードが一致するか検証している
    if @user && @user.authenticate(params[:session][:password])
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
      log_in @user
      redirect_to user_path(id: @user.id)
    else
      flash.now[:danger] = '名前またはパスワードが間違えています。もう一度入力してください。'
      render'new'
    end
  end

  def delete

  end

  def destroy
    log_out
    flash[:info] = "ログアウトしました"
    redirect_to root_url
  end

end

