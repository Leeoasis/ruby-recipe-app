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

  resources :recipes, except: [:update] do
    patch :toggle, on: :member
    resources :recipe_foods, only: [:new, :create, :destroy]
  end  
  
  get 'recipes/:id/shopping_list', to: 'foods#shopping_list', as: 'recipe_shopping_list'

  # Public recipe list routes
  get 'public_list', to: 'recipes#public_list', as: 'public_list_recipes'

  # Navigation menu routes
  root to: 'foods#index'
end
