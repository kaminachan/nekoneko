#UserクラスはApplicationRecord:baseクラスの全ての機能を持つことになる。
class User < ApplicationRecord
  #あるユーザーは複数のマイクロポストを持つ＜一対他＞,ユーザーが削除された場合、ユーザーのマイクロポストも削除
  has_many :microposts, dependent: :destroy

  #空白禁止、５０文字以内
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
  #空白禁止、６文字以上、半角英小文字大文字をそれぞれ一種類ずつ含む数字6 文字以上１００文字
  validates :password, presence: true, length: { minimum: 6 }, format: { with: /\A[a-z0-9]+\z/i }

  has_secure_password

  

  #トークンをデータベースに保存しないためアクセス可能な属性を作成する
 # attr_accessor :remember_token


  # 永続セッションのためにユーザーをデータベースに記憶する
 # def remember
  #self.キーワードを使わないとRubyによってローカル変数が作成されるので注意
  #self.remember_token = User.new_token
  #記憶ダイジェストを更新（ユーザーのパスワードなどにアクセスできないためバリデージョンを素通りさせる）
#  update_attribute(:remember_digest, User.digest(remember_token))
 # end

   #ランダムなトークンを返す
 # def User.new_token
    #SecureRandom.urlsafe_base64
#  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  #def authenticated?(remember_token)
  #  BCrypt::Password.new(remember_digest).is_password?(remember_token)
  # end

  # ユーザーのログイン情報を破棄する
  #def forget
  #  update_attribute(:remember_digest, nil)
  #end




end
