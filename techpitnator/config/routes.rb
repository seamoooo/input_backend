Rails.application.routes.draw do
  # ここにgamesコントローラーのnewアクションのルーティングを追加する
  root 'games#new'
  resources :games, only: %i[new create]
end
