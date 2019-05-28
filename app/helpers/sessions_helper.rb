module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end

  def authenticate_user
    if session[:user_id] == nil
      flash[:warning] = "会員情報を入力してくだい"
      redirect_to login_path
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session[:user_id] = nil
  end

  # 記憶したURL (もしくはデフォルト値) にリダイレクト
  def redirect_back_or(default)
    redirect_to(session[:return_url] || default)
    session.delete(:return_url)
  end

  # アクセスしようとしたURLを覚えておく
  def store_location
    session[:return_url] = request.url if request.get?
  end

end
