class CreateQuestionSimilarWords < ActiveRecord::Migration[5.2]
  def change
    create_table :question_similar_words do |t|
      t.integer :question_id, foreign_key: true
      t.string :similar_word

      t.timestamps
    end
  end
end
