Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'main#index'

  resources :members do
    member do
      get 'search_experts'
    end
  end
  resources :friendships
end
