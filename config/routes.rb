Rails.application.routes.draw do

  #HTTPリクエストやユーザー作成に必要なURLなどが作成される。
  #/user/:id のurlを有効にする（ないとログでエラー表記される）

  resources :questions
  resources :users

  resources :sessions, only: [:new, :create]

  get 'shared/_error_messages'
  get 'shared/error_message2'
  get 'shared/header'

  # ホーム画面
  root 'home#top'

  #ユーザー作成画面
  get  '/sign', to: 'users#new'
  post  '/sign', to: 'users#create'
  #ログイン管理画面
  get '/user/:id', to: 'users#show'
  get '/user/:id/edit', to: 'users#edit'
  patch '/user/:id(.:format)', to: 'users#update'

  get 'update', to: 'users#update_time'
  #ログイン画面
  get  '/login', to: 'sessions#new'
  post  '/login', to: 'sessions#create'
  delete '/logout', to:'sessions#destroy'

  #単語マスタメンテナンス
  get  '/index', to: 'questions#index'
  get '/search', to: 'questions#search'
  get  '/add', to: 'questions#add'
  post '/add', to: 'questions#create'
  get  '/question/:id/edit', to:'questions#edit'
  patch '/question/:id(.:format)', to: 'questions#update'
  delete '/question/:id', to: 'questions#destroy'

  #問題出題
  get  '/form', to: 'notebooks#form'
  post '/form', to:'notebooks#form'
  #終わった時に表示するランキング
  get  'form_2', to:'notebooks#form_2'
  post 'form_2', to:'notebooks#form_2'
  #ランキング
  get  'form_3', to:'notebooks#form_3'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
