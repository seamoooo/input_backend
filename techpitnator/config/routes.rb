Rails.application.routes.draw do
  # ここにgamesコントローラーのnewアクションのルーティングを追加する
  root 'games#new'

  # resourceは1つしか存在しないリソースを扱うため、indexを生成しない。
  resources :games, only: %i[new create] do
    member do
      get :give_up
    end
    resource :progresses, only: %i[new create]
  end
end
