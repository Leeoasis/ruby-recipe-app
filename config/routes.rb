Rails.application.routes.draw do
  devise_for :users

  # Login and registration pages
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    post 'login', to: 'devise/sessions#create'
    delete 'logout', to: 'devise/sessions#destroy'
    get 'register', to: 'devise/registrations#new'
    post 'register', to: 'devise/registrations#create'
  end

  # Food list routes
  resources :foods, except: [:update] do
    collection do
      get 'shopping_list', to: 'foods#shopping_list'
    end
  end

  resources :recipes do
    post :toggle, on: :member
    resources :recipe_foods, only: %i[new create destroy]
  end

  get 'recipes/:id/shopping_list', to: 'foods#shopping_list', as: 'recipe_shopping_list'

  # Public recipe list routes
  resources :public_recipes, only: [:index]

  # Navigation menu routes
  root to: 'foods#index'
end
