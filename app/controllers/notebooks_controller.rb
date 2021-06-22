class NotebooksController < ApplicationController
  before_action :authenticate_user, only: [:form, :form_2]
  

  def form
    if Question.all.count >= 50
      request.fullpath
    else
      flash[:danger] = "始めるには問題を５０問登録しましょう！"
      redirect_to questions_path
    end

    #クエスチョンテーブルからランダムにひとつレコードを取得
    if session[:no_id] == 1
      session[:arr] = []
    end

    if session[:arr].blank?
      @correct = Question.all.sample
    else
      @correct = Question.all.where.not(id: session[:arr]).sample
    end

    @answers  = Question.where.not(id: @correct).sample(2)
    #<< は配列にレコードを加える役割を担っている
    @arr = @answers << @correct

    p @correct


    if session[:no_id].blank? 
      session[:no_id] = 1
    end

    if session[:true_id].blank?
      session[:true_id] = 0
    end

    if session[:false_id].blank?
      session[:false_id] = 0
    end

    if request.post?
      # params[:answer]
      session[:no_id] += 1 #Okを押した後問題数を＋１
      # respond_to do |format|
      #   format.html {render action: 'form'}
      #   format.js
      # end

      if params[:correct] == params[:answer] #問題と解答のidが一致した場合
        session[:true_id] += 1
      else
        session[:false_id] += 1
      end

      if  session[:no_id] <= 50 #問題数が50になったらランキングへリダイレクト
        session[:arr] << @correct.id
        p session[:arr]
        render 'form'
      else
        @user_rank = (session[:true_id] / 50.to_i) * 100
        @true = (session[:true_id] / 50.to_i) * 100
        @user = User.find(session[:user_id])

        if @user.highest_rate.to_i <= @user_rank
          @user.highest_rate = @user_rank
          @user.save(validate: false)
        end
        flash[:success] = "お疲れ様でした！"
        flash[:warning] = "あなたの成績は、５０問中 #{session[:true_id]}問正解　正解率#{@true}％でした"
        redirect_to form_2_path
      end
     end
  end

  def form_2
    @ranking = User.order('highest_rate desc').where.not(highest_rate: 0).limit(10)

    #oderで多い順に並び替える
    #limitで表示する最大数を指定する

    session[:no_id] = nil
    session[:true_id] = nil
    session[:false_id] = nil

  end
  def form_3
    @ranking = User.order('highest_rate desc').where.not(highest_rate: 0).limit(10)

    #oderで多い順に並び替える
    #limitで表示する最大数を指定する

    session[:no_id] = nil
    session[:true_id] = nil
    session[:false_id] = nil

  end

  


end


