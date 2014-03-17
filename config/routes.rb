Questions::Application.routes.draw do


  resources :games

  root :to => 'home#index'
  devise_for :users,
    path_names: {
      sign_in: "zaloguj",
      sign_out: "wyloguj"
    },
    controllers: {
      omniauth_callbacks: "authentications",
      registrations: "registrations"
  }

  get '/kokpit', to: 'home#dashboard', as: 'dashboard'
  get '/konto', to: 'accounts#index', as: 'account'
  get '/konto/ustawienia', to: 'accounts#settings', as: 'account_settings'
  post '/konto/avatar/:id', to: 'accounts#avatar', as: 'avatar_settings'

  get '/ranking', to: "home#rankings", as: 'rankings'


  resources :quiz, only: [:index, :show] do
    resources :games, only: [:new, :create, :show] do
      member do
        get '/wyniki', to: 'games#results', as: 'results'
      end
      resources :replies, only: [:create]
    end
  end


  namespace :admin do
    # dashboard
    get '/', to: 'admin#dashboard', as: 'dashboard'

    resources :questions do
      resources :answers do
      end
    end
    resources :quizzes do
      resources :questions, only: [:index, :create]
      collection do
        get 'import', to: 'quizzes#import', as: 'import'
        post 'import', to: 'quizzes#import'
      end
      member do
        patch :publish
        patch :unpublish
        patch :expire
      end
    end

    resources :topics do
      member do
        patch :publish
        patch :unpublish
        patch :archive
      end
    end
  end

end