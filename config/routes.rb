Rails.application.routes.draw do
  root 'home#home_redirect'
  devise_for :users
  resources :users
  resources :norms
  resources :assessors
  resources :residents do
    put :make_assessor
  end
  shallow do
    resources :communities do
      resources :residents do
        resources :assessments
        resource :login
      end
    end
  end
end
