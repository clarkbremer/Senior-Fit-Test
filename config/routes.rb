Rails.application.routes.draw do
  root 'home#home_redirect'
  devise_for :users
  resources :users
  resources :assessors
  shallow do
    resources :communities do
      resources :residents do
        resources :assessments
      end
    end
  end
end
