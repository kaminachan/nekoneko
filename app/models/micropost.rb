class Micropost < ApplicationRecord
  #ユーザーと１対１の関係であることを表す
  #id, content, created_at, updated_atだけでなくuser_id属性も持つようになる
  belong_to :user

  #user_idが存在している状態かどうか（nilではないか)
  validates :user_id,presence: true
  validates :content, presence: true, length: { maximum: 140 }

  #データベースから要素を取得したときの、デフォルトの順序を指定
  default_scope -> { order(created_at: :desc) }



end
