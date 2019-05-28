class QuestionsController < ApplicationController
  before_action :authenticate_user, only: [:index, :add, :edit]

  def index
      @question = Question.paginate(page: params[:page], per_page: 20).order('id').search(params[:search])
  end

  #単語検索ページ
  def search
    @question = Question.search(params[:search])
  end

#単語の作成ができるフォーム
  def add
      @question= Question.new
      @question_similar_word = @question.question_similar_words.build
  end

  def create
      @question = Question.new(question_params)
      if @question.save
        flash[:success] = "登録が完了しました"
        redirect_to index_path
      else
        flash.now[:danger] = "登録に失敗しました。再度入力してください"
        render 'add'
      end
  end

#単語の編集・削除ができるフォーム（question/:id)につなぐ
  def edit
      @question = Question.find(params[:id])
  end

  def update
      @question = Question.find(params[:id])
      if @question.update(question_params)
        flash[:success] = "更新しました"
        redirect_to index_path
      else
        flash.now[:danger] = "更新に失敗しました。再度入力してください"
        render 'edit'
      end
  end


  def delete
      @question = Question.find(params[:id])
  end

  def destroy
      @question = Question.find(params[:id])
      if @question.destroy
        flash[:danger] = "削除しました"
        redirect_to index_path
      end
  end




private #外部から使えないようにするものが以下
  #それぞれの属性を必須、以外の属性は許可しない
  def question_params
      params.require(:question).permit(:question, :description, :_destroy,question_similar_words_attributes: [:id, :question_id, :similar_word, :_destroy] )

  end

end
