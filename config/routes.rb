Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :games, only: [:index, :new, :create]
  resources :events do
    collection do
      get 'index_my'
    end
  end


end
