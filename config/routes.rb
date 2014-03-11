Questions::Application.routes.draw do


  resources :games

  root :to => 'home#index'
  devise_for :users, :controllers => {:registrations => 'registrations'}
  resources :users
  get '/dashboard', to: 'home#dashboard', as: 'dashboard'


  resources :quiz, only: [:index, :show] do
    resources :games, only: [:new, :create, :show] do
      member do
        get '/wyniki', to: 'games#results', as: 'results'
      end
      resources :replies, only: [:create]
    end
  end

  # dashboard
  namespace :admin do
    resources :questions do
      resources :answers
    end
    resources :quizzes do
      resources :questions, only: [:index, :create]
      collection do
        get 'import', to: 'quizzes#import', as: 'import'
        post 'import', to: 'quizzes#import'
      end
      member do
        patch 'publish'
        patch 'unpublish'
        patch 'expire'
      end
    end

    get '/', to: 'admin#dashboard', as: 'dashboard'
  end

end