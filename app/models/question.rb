class Question < ApplicationRecord

  has_many :question_similar_words, dependent: :destroy
  accepts_nested_attributes_for :question_similar_words,allow_destroy: true
  #空欄禁止
  validates :question, presence: true, uniqueness: true
  validates :description, presence: true, uniqueness: true

 def self.search(search) #self.でクラスメソッドとしている
    if search # Controllerから渡されたパラメータが!= nilの場合は、titleカラムを部分一致検索
      Question.where(['question LIKE ? OR description LIKE ?', "%#{search}%", "%#{search}%"])
    else
      Question.all #全て表示。
    end
 end
end

