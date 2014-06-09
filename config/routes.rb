Rails.application.routes.draw do
  root 'index#index'

  devise_for :users, :skip => :all
  as :user do
    get    "/account/sign_in"  => "sessions#new"
    post   "/account/sign_in"  => "sessions#create"
    delete "/account/sign_out" => "sessions#destroy"
  end

  namespace :manage do
    resources :nets, :shallow => true do
      member do
        get :graph
      end

      resources :points, :shallow => true
    end

    resources :users, :shallow => true do
    end
  end

  
  resources :plans, :shallow => true do
    resources :topics do
      resources :tutorials
    end
  end

end