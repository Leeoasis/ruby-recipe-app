Rails.application.routes.draw do
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
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

  # Recipes list routes
  resources :recipes, except: [:update]

  # Public recipe list routes
  resources :public_recipes, only: [:index]

  # Recipe details routes
  resources :recipes, only: [:show] do
    resources :foods, only: %i[new create], module: :recipes
  end

  resources :recipes do
    patch 'toggle_public', on: :member
  end

  # Navigation menu routes
  root to: 'foods#index'
end
